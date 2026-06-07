# Architecture and State Management

When building a Flutter app, you often need to share data between different screens or widgets. If you manage state by simply passing variables down through widget constructors, it can quickly become messy.

Consider a shopping cart: the home screen needs to show the number of items in the cart, the product detail screen needs to let users add items, and the checkout screen needs to list all items. If you try to pass the cart data down from the top of the app using constructor arguments, you will end up threading that data through widgets that don't even care about it just to get it to the widgets that do. This is called **prop drilling**, and it becomes unmanageable as your app grows.

To solve this problem cleanly, we need two things:
1. A clear **architecture** to organize our codebase.
2. A dedicated **state management** system to handle sharing and updating data.

## Two kinds of state

Before reaching for a state management solution, it's worth knowing which problem you're actually solving.

**Ephemeral state** is state that lives entirely inside one widget and is nobody else's business. Whether a dropdown is open, the current value of a text field, or whether an animation is playing; that's ephemeral state. `StatefulWidget` and `setState` are perfectly fine for this.

**App state** is state that multiple parts of your app need to read or change. The shopping cart, the user's favorites list, the current user session; these belong to your app, not to any single widget. Passing this kind of state through constructors scales poorly; you need a proper solution.

## App architecture - feature-first folders

Before diving into state management libraries, it helps to understand how `my_store` is organised. The folder structure is not arbitrary; it follows a **feature-first, layered architecture** that scales well as an app grows.

```
lib/
├── core/              # App-wide utilities
│   ├── consts/        # Strings, dimensions, etc.
│   ├── extensions/    # Dart extension methods
│   ├── routes/        # Centralised route definitions
│   └── theme/         # App theme
│
├── features/          # Each screen is a feature
│   ├── cart/
│   ├── home/
│   ├── orders/
│   ├── product_details/
│   └── splash/
│
├── shared/            # State & widgets used by multiple features
│   ├── cart/
│   ├── favorites/
│   ├── product/
│   ├── remote_config/
│   └── widgets/
│
└── mock_server/       # Simulated backend
```

**`features/`** contains everything that belongs to a single screen. If a screen is deleted, its folder goes with it.

**`shared/`** contains state and widgets that multiple features depend on. The cart, for example, is needed on the home page (badge to show number of items), product details page (add to cart button), and the cart page itself (to perform operations on cart); so it lives in `shared/`.

**`core/`** contains infrastructure that has nothing to do with features: themes, routing, constants.

### The three-layer pattern

Every module in `features/` and `shared/` follows the same internal structure:

```
product/
├── domain/            # Pure Dart: what a product IS
│   ├── entities/      # Data classes (Product, Price)
│   └── repositories/  # Interfaces (abstract contracts)
├── data/              # How data is fetched
│   ├── data_sources/
│   └── repositories/  # Implementations of domain interfaces
└── presentation/      # Flutter: state/logic and widgets
    └── state_management/         # State managers, directory name can be anything, e.g. bloc, providers, etc
```

| Layer | Depends on | Contains |
| :---- | :--------- | :------- |
| `domain` | Nothing | Entities, repository interfaces |
| `data` | `domain` | Repository implementations, data sources |
| `presentation` | `domain`, State Manager | State managers, widgets |

The key rule: **lower layers never import from higher ones.** Domain knows nothing about state management or UI. Data knows nothing about UI. This means you can swap the mock server for a real HTTP backend by only touching the `data/` layer.

Here's how those three layers relate to each other:

```mermaid
flowchart LR
    P[presentation\nState & Widgets] -->|reads| D[domain\nEntities & Interfaces]
    DA[data\nImplementations] -->|implements| D
    P -->|uses injected| DA
```

## The domain layer - entities and repository contracts

Domain is the foundation. It defines what your data looks like and what operations exist, without caring how they're implemented.

A **entity** is a plain Dart class representing a concept in your app:

```dart
// shared/product/domain/entities/product.dart
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) { ... }

  final String id;
  final String name;
  final String description;
  final Price price;
  final String imageUrl;
}
```

No Flutter UI imports. No state management libraries. Just Dart.

A **repository interface** defines what data operations are available, without implementing them:

```dart
// shared/product/domain/repositories/product_repository.dart
abstract interface class ProductRepository {
  Future<String> getHeroProductId();
  Future<List<String>> getFeaturedProductIds();
  Future<List<Product>> getProductsByIds({
    required List<String> productIds,
    bool skipCache = false,
  });
}
```

`abstract interface class` means "this is a contract; any class that claims to be a `ProductRepository` must provide all of these methods." The rest of the app only ever talks to this interface, never to a concrete implementation directly. This is what makes swapping implementations possible.

## The data layer - implementing the contract

Recall that the domain layer only defines *what* operations exist, not *how* they work. The data layer is where that "how" lives; it provides concrete classes that fulfill the domain contracts by actually fetching, storing, or caching data.

`MockProductRepository` fulfills the `ProductRepository` contract by talking to the `MockServer`:

```dart
// shared/product/data/repositories/mock_product_repository.dart
final class MockProductRepository implements ProductRepository {
  final Map<String, Product> _allProductsCache = {};

  @override
  Future<List<Product>> getProductsByIds({
    required List<String> productIds,
    bool skipCache = false,
  }) async {
    final missingIds = skipCache
        ? productIds
        : productIds.where((id) => !_allProductsCache.containsKey(id)).toList();

    if (missingIds.isNotEmpty) {
      final rawProducts = await MockServer.getProductsByIds(missingIds);
      final response = ProductsPayload.fromJson(rawProducts);
      _updateCache(response.products);
    }

    return productIds
        .map((id) => _allProductsCache[id])
        .whereType<Product>()
        .toList();
  }
}
```

### Accessing repositories in the app

Widgets don't use repositories directly. Instead, repositories are created once and made available to the parts of your app that need them - such as your state managers or controllers - through a process called **dependency injection**.

Think of it like a supply room: rather than each worker going out to find their own tools, someone stocks the supply room once, and everyone draws from it. In Flutter, this "supply room" is usually a dependency injection container or a service locator - a central place where your repositories live and can be looked up by whoever needs them.

This separation matters for a few reasons:

- **Your UI stays clean.** Widgets only ask for data; they don't know or care where it comes from.
- **Swapping implementations becomes easy.** Want to replace a fake in-memory repository with one that calls a real API? You change it in one place, and nothing else needs to know.
- **Testing is simpler.** You can hand the app a fake repository during tests without touching any widget code.

## The presentation layer - state management and widgets

The presentation layer is where your app comes to life. It's the bridge between the data your repositories provide and the UI your users actually see.

It holds two kinds of things:

- **State managers / controllers** - these are responsible for fetching data from repositories, keeping track of what's happening in the UI (like whether a button is loading or a list is empty), and exposing ways to trigger actions. Depending on your state management library, these might be called BLoCs, Cubits, Notifiers, Controllers, or something else entirely.
- **Widgets** - Flutter widgets that watch the state manager and rebuild whenever something changes.

```
shared/cart/presentation/
├── state/ # Holds UI state and business logic
└── widgets/
    ├── add_to_cart_button.dart  # Widget that interacts with the cart state
    └── cart_badge.dart
```

One important rule about this layer: **it's the only layer that imports Flutter or your state management library.** The domain and data layers are plain Dart; no Flutter, no external state libraries. That boundary is what keeps the architecture clean. If your business logic ever ends up importing Flutter widgets, that's a sign something has leaked into the wrong layer.

## State management with Riverpod

### Why Riverpod?

Flutter has several state management options. Riverpod is a good choice for learning because:

- Providers are **compile-safe** — typos in provider names fail at compile time, not at runtime.
- Providers don't require `BuildContext` to be read or written from Dart code outside widgets.
- Providers are **lazy** by default — they only run when something is listening.
- Everything is **reactive** — widgets automatically rebuild when the state they're watching changes.

This project uses two packages. You can see them in `pubspec.yaml`:

```yaml
dependencies:
  flutter_riverpod: ^3.3.1    # The core library
  riverpod_annotation: ^4.0.2 # Annotations for code generation

dev_dependencies:
  build_runner: ^2.15.0       # Runs the code generator
  riverpod_generator: ^4.0.3  # The actual generator
```

`flutter_riverpod` is the runtime. `riverpod_annotation` + `riverpod_generator` let you write providers with annotations (`@riverpod`) instead of writing boilerplate by hand.

### `ProviderScope` — the root of everything

Riverpod needs a `ProviderScope` widget at the very top of your widget tree. It acts as the container that stores all provider state. Nothing Riverpod-related works without it.

```dart
// main.dart
void main() {
  runApp(
    ProviderScope(
      retry: (retryCount, error) => null, // disable automatic retry
      child: const App(),
    ),
  );
}
```

The `retry` parameter controls what happens when an async provider throws. Setting it to `null` means "don't automatically retry — let the UI handle it."

## Riverpod fundamentals

### Code generation — what `@riverpod` does

Writing Riverpod providers by hand requires a lot of boilerplate. Instead, you annotate a class or function with `@riverpod`, run the generator, and it writes the boilerplate for you.

Here's a provider you write:

```dart
// shared/product/presentation/providers/product_notifier.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_notifier.g.dart'; // ← tells Dart: generated code lives here

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<Product?> build(String id) async {
    final repository = ref.watch(productRepositoryProvider);
    final products = await repository.getProductsByIds(productIds: [id]);
    return products.firstOrNull;
  }
}
```

The `part 'product_notifier.g.dart'` directive tells Dart that some of this file's code lives in a generated file. The `_$ProductNotifier` class (underscore, dollar sign) is generated — it provides the `ref` property, wires up the lifecycle hooks, and does other plumbing you never have to touch.

To generate or re-generate the `.g.dart` files, run:

```bash
dart run build_runner build
# or, to watch for changes automatically:
dart run build_runner watch
```

The generated file creates a `productProvider` that you use in your widgets. You never call `ProductNotifier` directly — you always go through the generated provider.

> **Tip:** You don't need to read `.g.dart` files. They're implementation detail. If you're curious, open one — but treat it like compiled output: generated, not maintained by hand.

### `AsyncNotifier` — providers that load data asynchronously

Most real-world providers do async work: fetch from a server, read from a database, parse a file. The `build` method returning a `Future` is what makes a provider asynchronous:

```dart
@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  Future<HomePageData> build() async {
    final repository = ref.watch(productRepositoryProvider);

    // Fire two requests in parallel and wait for both
    final (heroProductId, featuredProductIds) = await (
      repository.getHeroProductId(),
      repository.getFeaturedProductIds(),
    ).wait;

    return HomePageData(
      heroProductId: heroProductId,
      featuredProductIds: featuredProductIds,
    );
  }
}
```

When `build` returns a `Future`, Riverpod wraps the result in an `AsyncValue<T>`. This is a type that represents one of three possible states:

```
AsyncValue<T>
  ├── AsyncLoading   — the future hasn't resolved yet
  ├── AsyncData<T>   — success, holds the value
  └── AsyncError     — failure, holds the error and stack trace
```

### `ConsumerWidget` and `ref.watch`

To read a provider in a widget, extend `ConsumerWidget` instead of `StatelessWidget`. The only difference is an extra `WidgetRef ref` argument in `build`:

```dart
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageDataAsync = ref.watch(homeProvider);

    return Scaffold(
      body: homePageDataAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: GenericErrorView(
            onRetry: () => ref.invalidate(homeProvider),
          ),
        ),
        data: (homePageData) => _HomePageBody(homePageData: homePageData),
      ),
    );
  }
}
```

`.when()` is the cleanest way to handle all three `AsyncValue` states in one go. Each callback returns a widget.

**`ref.watch` vs `ref.read`** is one of the most important things to understand:

| | `ref.watch` | `ref.read` |
| :-- | :---------- | :--------- |
| **Subscribes?** | Yes — widget rebuilds when state changes | No — one-time read |
| **Use in** | `build()` method | Callbacks, event handlers, actions |
| **Why** | You want the UI to stay in sync | You just need the current value or the notifier |

```dart
// ✅ Correct: watch in build, so the cart badge updates when cart changes
final cartAsync = ref.watch(cartProvider);

// ✅ Correct: read in a callback, you don't need to subscribe
void onPressed() {
  ref.read(cartProvider.notifier).addItem(product.id);
}

// ❌ Wrong: never watch inside a callback — it does nothing useful there
void onPressed() {
  ref.watch(cartProvider); // pointless and potentially harmful
}
```

### Parameterised providers

Sometimes you need the same kind of data for different inputs — one `Product` per product ID, for example. Riverpod handles this with **family providers**: pass an argument to the provider and you get a separate provider instance for each unique argument.

```dart
@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<Product?> build(String id) async { // ← the argument
    final repository = ref.watch(productRepositoryProvider);
    final products = await repository.getProductsByIds(productIds: [id]);
    return products.firstOrNull;
  }
}
```

In widgets, you call it with the argument:

```dart
// Watches the product with this specific ID
// A different widget watching a different ID won't cause it to rebuild
final productAsync = ref.watch(productProvider('product-abc-123'));
```

Each argument creates its own independent provider instance with its own state. Five widgets watching five different product IDs are five completely separate providers under the hood.

### `ref.invalidate` — forcing a refresh

Invalidating a provider disposes its current state and rebuilds it from scratch. This is how retry buttons work:

```dart
// Force the home page to re-fetch all its data
onRetry: () => ref.invalidate(homeProvider),

// Invalidate only a specific product (family providers need the argument)
ref.invalidate(productProvider('product-abc-123'));
```

Inside a notifier, use `ref.invalidateSelf()` to invalidate the provider you're currently in:

```dart
// After placing an order, refresh the cart by re-running build()
ref.invalidateSelf();
```

## Cross-provider dependencies

Providers can depend on other providers. `CartNotifier` needs both the cart repository *and* the product repository — it fetches cart items (which only contain product IDs) and then resolves them into full `Product` objects:

```dart
@riverpod
class CartNotifier extends _$CartNotifier {
  @override
  Future<CartSnapshot<HydratedCartItem>> build() async {
    final cartRepository = ref.watch(cartRepositoryProvider);
    final productRepository = ref.watch(productRepositoryProvider);

    final cart = await cartRepository.getOrCreateCart();

    final products = await productRepository.getProductsByIds(
      productIds: cart.items.map((i) => i.productId).toList(),
    );

    // Pair each CartItem with its full Product object
    final productMap = {for (final p in products) p.id: p};
    final hydratedItems = cart.items.map((cartItem) {
      final product = productMap[cartItem.productId]!;
      return HydratedCartItem(cartItem: cartItem, product: product);
    }).toList();

    return CartSnapshot(isMutating: false, cart: Cart(items: hydratedItems, ...));
  }
}
```

`HydratedCartItem` is a simple pair: the raw cart item (product ID + quantity + price) plus the resolved `Product` (name, image, description). This pattern of "joining" data from two sources inside a provider is very common.

When `cartRepositoryProvider` or `productRepositoryProvider` state changes, `CartNotifier` automatically rebuilds because it called `ref.watch` on both. Dependencies are tracked automatically.

## Mutating state — writing back to providers

Providers don't just read data — they can also expose methods that change it. In `CartNotifier`, `addItem` and `removeItem` are public methods that widgets can call:

```dart
Future<void> addItem(String productId) async {
  final existing = await _getItemByID(productId);
  return _updateQuantity(productId, (existing?.cartItem.quantity ?? 0) + 1);
}
```

Widgets trigger mutations through the **notifier**:

```dart
// In a widget's callback:
ref.read(cartProvider.notifier).addItem(product.id);
```

Note `ref.read` here, not `ref.watch` — in a callback you just need the notifier once, you're not subscribing.

### The `isMutating` flag — preventing double actions

When a network call is in flight, you don't want the user to be able to trigger another one. `CartSnapshot` carries an `isMutating` flag for exactly this:

```dart
Future<void> _updateQuantity(String productId, int quantity) async {
  final snapshot = state.value ?? await future;
  if (snapshot.isMutating) return; // already busy, bail out

  // 1. Update the UI immediately (optimistic update)
  state = AsyncData(snapshot.copyWith(isMutating: true, cart: optimisticCart));

  try {
    // 2. Hit the server
    final updatedCart = await cartRepository.updateItem(...);
    // 3. Replace optimistic state with real server response
    state = AsyncData(CartSnapshot(isMutating: false, cart: updatedCart));
  } catch (e, st) {
    // 4. Roll back to the previous state on failure
    state = AsyncData(snapshot.copyWith(isMutating: false));
    state = AsyncError(e, st);
  }
}
```

This is the **optimistic update** pattern: update the UI before the server confirms, then correct it if something goes wrong. It makes the app feel instant even over a slow connection.

> **Note:** `state = AsyncData(...)` is how you manually set a notifier's state from inside the notifier. Setting `isMutating: true` first, then the server result after — that's two separate state updates that each trigger a UI rebuild.

## Shared widgets with built-in provider logic

One of Riverpod's strengths is that any `ConsumerWidget` can connect to providers without being handed data through constructor arguments. This allows you to build **self-contained widgets** that manage their own provider connections.

### `AddToCartButton`

```dart
class AddToCartButton extends ConsumerWidget {
  const AddToCartButton({required this.product, ...});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onPressed() {
      final snapshot = ref.read(cartProvider);
      if (snapshot.value?.isMutating ?? false) {
        AppSnackBar.showErrorSnackBar(context, message: 'Processing...');
        return;
      }
      ref.read(cartProvider.notifier).addItem(product.id);
      AppSnackBar.showSuccessSnackBar(context, message: '${product.name} added to cart');
    }

    return PrimaryButton(text: 'Add to Cart', onTap: onPressed);
  }
}
```

This widget reads the cart state, prevents duplicate actions, calls the mutation, and shows a snackbar — all internally. The parent widget just passes the `Product` and forgets about it.

### `FavoriteButton` — mixing local and provider state

Some widgets need both local ephemeral state (an animation) and provider state (is this item favorited?). For that, use `ConsumerStatefulWidget`:

```dart
class FavoriteButton extends ConsumerStatefulWidget { ... }

class _FavoriteButtonState extends ConsumerState<FavoriteButton>
    with SingleTickerProviderStateMixin {

  late final AnimationController _controller; // local animation state

  @override
  Widget build(BuildContext context) {
    // Provider state — is this product in the user's favorites?
    final isFavorite = ref.watch(
      favoritesProvider.select(
        (s) => s.value?.contains(widget.productId) ?? false,
      ),
    );

    return GestureDetector(
      onTap: () {
        _controller.forward(from: 0.0); // trigger animation locally
        ref.read(favoritesProvider.notifier).toggle(widget.productId); // update provider
      },
      child: AnimatedSwitcher(
        child: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, ...),
      ),
    );
  }
}
```

`ConsumerState` works exactly like regular Flutter `State`, but has `ref` built in.

### Selective rebuilds with `.select`

Notice `.select` in the example above:

```dart
ref.watch(
  favoritesProvider.select(
    (s) => s.value?.contains(widget.productId) ?? false,
  ),
);
```

Without `.select`, this widget would rebuild every time *any* favorite is toggled, even ones it doesn't care about. `.select` narrows the subscription: this widget only rebuilds when the boolean for *this specific product* changes. For a list with many items, that's a significant performance improvement.

## Sealed classes for complex state

Sometimes a provider's state isn't just "loading, data, error" — it can be one of several distinct outcomes with different data. Dart's `sealed class` is perfect for this.

The splash screen needs to communicate three possible outcomes after startup checks:

```dart
// features/splash/presentation/providers/splash_state.dart
sealed class SplashState {
  const SplashState();
}

class Success extends SplashState {
  const Success();
}

class UnderMaintenance extends SplashState {
  const UnderMaintenance({required this.message, this.details});
  final String message;
  final String? details;
}

class ForceUpdate extends SplashState {
  const ForceUpdate({required this.message, this.details});
  final String message;
  final String? details;
}
```

The notifier runs its checks and returns one of these:

```dart
@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  Future<SplashState> build() async {
    final appInfoRepository = ref.watch(appInfoRepositoryProvider);
    final remoteConfigRepository = ref.watch(remoteConfigRepositoryProvider);

    // Fetch both in parallel
    final (currentBuildNumber, _) = await (
      appInfoRepository.readAppBuildNumber(),
      remoteConfigRepository.fetchRemoteConfig(),
    ).wait;

    final config = remoteConfigRepository.getRemoteConfig();

    if (config.maintenanceConfig.isInMaintenanceMode) {
      return UnderMaintenance(
        message: config.maintenanceConfig.message,
        details: config.maintenanceConfig.details,
      );
    }

    if (currentBuildNumber < config.minSupportedBuildNumber) {
      return const ForceUpdate(
        message: 'New Version Available',
        details: 'Please update to continue.',
      );
    }

    return const Success();
  }
}
```

In the UI, `switch` on a sealed class gives you **exhaustive pattern matching** — the compiler tells you if you forget a case:

```dart
final splashState = splashStateAsync.value;
switch (splashState) {
  case Success():   Navigator.pushReplacementNamed(context, HomePage.routeName);
  case UnderMaintenance(): SplashMaintenanceView(message: splashState.message);
  case ForceUpdate():      SplashForceUpdateView(message: splashState.message);
}
```

The compiler knows every possible subclass of a sealed class, so if you add a new one and forget to handle it, you get a compile error — not a runtime crash.

## The `my_store` app

The `my_store` folder contains a complete e-commerce app that puts all the concepts from this module into practice.

### What you'll learn from it

**Feature-first architecture with three layers**; every module in `features/` and `shared/` follows the `domain/` → `data/` → `presentation/` structure. Changing the data source only requires touching the `data/` layer.

**`ProviderScope` and `keepAlive` repositories**; `main.dart` wraps the app in `ProviderScope`. All repository providers use `@Riverpod(keepAlive: true)` so their caches survive widget disposal.

**Async providers with `.when()`**; every page (`HomePage`, `CartPage`, `OrdersPage`) watches an async provider and uses `.when()` to render loading spinners, error views with retry buttons, and the actual content.

**Parameterised providers**; `productProvider(productId)` is a family provider. The home page, product details page, and orders page each watch the same provider with different IDs, getting independent provider instances with no shared rebuild overhead.

**Cross-provider dependencies**; `CartNotifier.build` watches both `cartRepositoryProvider` and `productRepositoryProvider`, joining cart items with product data inside the provider.

**Optimistic updates and rollback**; `CartNotifier._updateQuantity` updates the UI instantly before the server confirms, then rolls back on failure. The `isMutating` flag prevents overlapping mutations.

**Self-contained smart widgets**; `AddToCartButton`, `FavoriteButton`, and `CartBadge` each connect to their providers internally. Parents pass only the product or product ID — no callback props needed.

**Selective rebuilds**; `FavoriteButton` uses `.select` to subscribe only to the boolean for its specific product, avoiding unnecessary rebuilds when other favorites change.

**Sealed class state**; `SplashState` is a sealed class with `Success`, `UnderMaintenance`, and `ForceUpdate`. The compiler enforces that every case is handled everywhere `SplashState` is used.

**Debounced quantity updates**; `_QuantitySelector` in `CartPage` uses a local `Timer` to wait 750ms after the last tap before firing the network request, avoiding a request on every individual `+` / `-` press.

### How to run

```bash
cd my_store
flutter pub get
dart run build_runner build  # generate the .g.dart files
flutter run
```
