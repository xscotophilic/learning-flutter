# Architecture and State Management

## Project Structure

```text
├── README.md
├── docs/
│   ├── 01.architecture.md
│   ├── 02.dependency-injection.md
│   ├── 03.riverpod-basics.md
|   ├── 04.advanced-patterns.md
|   └── 05.my-store-walkthrough.md
└── my_store/
    └── Complete showcase application
```

## What We Will Learn

- Organising Flutter projects using a feature-first structure
- Separating business logic from UI
- Building framework-agnostic domain layers
- Injecting dependencies cleanly
- Managing state with Riverpod
- Handling async loading, errors, and mutations
- Optimising rebuild performance

## Why Do We Need Architecture and State Management?

When building a Flutter app, you often need to share data between different screens or widgets. If you manage state by simply passing variables down through widget constructors, it can quickly become messy.

Consider a shopping cart: the home screen needs to show the number of items in the cart, the product detail screen needs to let users add items, and the checkout screen needs to list all items. If you try to pass the cart data down from the top of the app using constructor arguments, you will end up threading that data through widgets that don't even care about it just to get it to the widgets that do. This is called **prop drilling**, and it becomes unmanageable as your app grows.

To solve this problem cleanly, we need two things:

1. A clear **architecture** to organize our codebase.
2. A dedicated **state management** system to handle sharing and updating data.

Before reaching for a state management solution, it's worth knowing which problem you're actually solving.

**Ephemeral state** is state that lives entirely inside one widget and is nobody else's business. Whether a dropdown is open, the current value of a text field, or whether an animation is playing; that's ephemeral state. `StatefulWidget` and `setState` are perfectly fine for this.

**App state** is state that multiple parts of your app need to read or change. The shopping cart, the user's favorites list, the current user session; these belong to your app, not to any single widget. Passing this kind of state through constructors scales poorly; you need a proper solution.

## Documentation

### Recommended Reading Order

If you're new to these concepts:

1. [docs/architecture.md](docs/01.architecture.md)
2. [docs/dependency_injection.md](docs/02.dependency_injection.md)
3. [docs/riverpod_basics.md](docs/03.riverpod_basics.md)
4. [docs/advanced_patterns.md](docs/04.advanced_patterns.md)
5. [docs/my_store_walkthrough.md](docs/05.my_store_walkthrough.md)

### Section 1: Architecture

Learn how the project is organised and how Clean Architecture is applied. Check [docs/architecture.md](docs/01.architecture.md).

### Section 2: Dependency Injection

Learn how dependencies are wired together and why abstractions matter. Check [docs/dependency_injection.md](docs/02.dependency_injection.md).

### Section 3: Riverpod Basics

Learn the Riverpod concepts used throughout the project. Check [docs/riverpod_basics.md](docs/03.riverpod_basics.md).

### Section 4: Riverpod Advanced Patterns

Production-oriented Riverpod patterns and UI optimisations. Check [docs/advanced_patterns.md](docs/04.advanced_patterns.md).

### Section 5: Showcase App Walkthrough

Explore how all concepts are applied in a complete application. Check [docs/my_store_walkthrough.md](docs/05.my_store_walkthrough.md).
