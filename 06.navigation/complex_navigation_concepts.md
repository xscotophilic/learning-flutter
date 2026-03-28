# Complex Navigation Concepts

> **Note:** For fundamental routing, pushing, popping, and named routes, see [README.md](README.md).

## Table of Contents

- [Reading Route Arguments Early](#reading-route-arguments-early)
  - [What are the options?](#what-are-the-options)
    - [1. `didChangeDependencies` (most common fix)](#1-didchangedependencies-most-common-fix)
    - [2. Read args in `build`](#2-read-args-in-build)
    - [3. Pass args as constructor parameters (cleanest architecture)](#3-pass-args-as-constructor-parameters-cleanest-architecture)
- [Persistent bottom navigation with nested stacks](#persistent-bottom-navigation-with-nested-stacks)

## Reading Route Arguments Early

Reading route arguments in `initState` doesn't work because `context` isn't fully mounted yet at that point. `ModalRoute.of(context)` requires an active route binding, which only exists after the widget is fully inserted into the tree.

**The core issue:** `initState` runs before the widget's `BuildContext` is associated with a route, so `ModalRoute.of(context)` returns `null`.

### What are the options?

#### 1. `didChangeDependencies` (most common fix)

```dart
@override
void didChangeDependencies() {
  super.didChangeDependencies();
  final args = ModalRoute.of(context)?.settings.arguments as ...;
}
```

This is called after `initState` once the context has full route access. Be careful, it can fire multiple times, so guard with a flag if needed.

Why `didChangeDependencies` works?

- Flutter's lifecycle order is:
  - `constructor` -> `initState` -> `didChangeDependencies` -> `build`
- By the time of `didChangeDependencies`, the `InheritedWidget` tree (which `ModalRoute.of` depends on) is fully wired up.

#### 2. Read args in `build`

```dart
@override
Widget build(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as ...;
  // use args directly
}
```

Simple, but re-evaluates on every rebuild. Works fine for StatelessWidget, but for StatefulWidget, it's better to use `didChangeDependencies`.

#### 3. Pass args as constructor parameters (cleanest architecture)

```dart
class MyScreen extends StatefulWidget {
  final Map<String, String> args;
  const MyScreen({required this.args});
}
```

Then read in `initState` freely via `widget.args`. Avoids coupling your widget to routing internals entirely.

## Persistent bottom navigation with nested stacks

The simple index-swap pattern works well for flat apps, but it has a limitation: switching tabs resets the page. If a user drills into a detail screen on tab A, then switches to tab B and back, they land on tab A's root again. The stack is never preserved.

The solution is to give each tab its own `Navigator`, each with its own independent stack.

```dart
class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;
  late final List<_PageData> _pages;

  // Each tab gets its own GlobalKey to preserve its Navigator state
  late final List<GlobalKey<NavigatorState>> _navigatorKeys;

  @override
  void initState() {
    super.initState();
    _pages = [
      const _PageData(
        title: 'Categories',
        icon: Icons.dashboard,
        page: CategoriesGridView(),
      ),
      _PageData(
        title: 'Favorites',
        icon: Icons.favorite,
        page: FavouriteListView(favouriteMeals: widget.favouriteMeals),
      ),
    ];

    // One key per tab: created once, never recreated
    _navigatorKeys = List.generate(
      _pages.length,
      (_) => GlobalKey<NavigatorState>(),
    );
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _buildTabNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => _pages[index].page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigatorPopHandler(
      // Pop within the current tab before letting the OS close the app
      onPopWithResult: (result) {
        return _navigatorKeys[_selectedPageIndex].currentState?.pop(result);
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: List.generate(
            _pages.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(_pages[index].icon),
              label: _pages[index].title,
            ),
          ),
        ),
        // IndexedStack keeps all tabs alive — only the selected one is visible
        body: IndexedStack(
          index: _selectedPageIndex,
          children: List.generate(_pages.length, _buildTabNavigator),
        ),
      ),
    );
  }
}
```

Each tab's `Navigator` manages its own stack independently; navigating inside tab A doesn't affect tab B's stack at all.

> **Note:** This is significantly more complex to set up and debug. Only reach for it when your app genuinely needs per-tab navigation history. For most apps, the simple index-swap pattern is enough.
