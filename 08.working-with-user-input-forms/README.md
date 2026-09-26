# Working with User Input & Forms

## Project Structure

```text
├── README.md
├── docs/
│   ├── 01.flutter_forms.md
│   ├── 02.input_validation.md
│   ├── 03.mutations_and_ref_listen.md
│   └── 04.my_store_walkthrough.md
└── my_store/
    └── Complete showcase application
```

## What We Will Learn

- Collecting text input using `TextFormField`
- Managing controller lifecycle with `TextEditingController`
- Coordinating form-wide validation with `Form` and `GlobalKey<FormState>`
- Centralising input styling with `InputDecorationTheme`
- Writing field-level validators for required, numeric, optional, and URL fields
- Restricting allowed characters at input time with `inputFormatters`
- Reacting to provider state changes for side effects using `ref.listen`
- Extending a Riverpod `AsyncNotifier` with full CRUD mutations
- Debouncing text input to drive live previews

## Why Do We Need Forms?

Most production applications need to collect data from users: sign-up forms, product listings, profile editors, checkout flows. Flutter provides the raw tools, but without structure it is easy to end up with scattered state, inconsistent validation timing, and hard-to-test code.

The `Form` widget solves the coordination problem: it wraps multiple fields and lets you trigger validation across all of them with a single method call. Combined with `TextEditingController` for reading and pre-populating values, and `inputFormatters` for restricting characters as they are typed.

If we mutate server data, on the state management side we need to handle loading, success, and error states. This chapter extends the Riverpod patterns from [Architecture and State Management Chapter](../07.architecture-and-state-management/README.md) with `ref.listen`.

## Documentation

### Recommended Reading Order

If you're new to these concepts:

1. [docs/01.flutter_forms.md](docs/01.flutter_forms.md)
2. [docs/02.input_validation.md](docs/02.input_validation.md)
3. [docs/03.mutations_and_ref_listen.md](docs/03.mutations_and_ref_listen.md)
4. [docs/04.my_store_walkthrough.md](docs/04.my_store_walkthrough.md)

### Section 1: Flutter Forms

Learn how `Form`, `TextFormField`, `TextEditingController`, and `InputDecorationTheme` work together to build structured, consistently styled input forms. Check [docs/01.flutter_forms.md](docs/01.flutter_forms.md).

### Section 2: Input Validation & Formatters

Learn how to write field-level validators, restrict characters with `inputFormatters`, build reusable field widgets, debounce live previews, and implement a custom animated dropdown (cause flutter's dropdown doesn't look good). Check [docs/02.input_validation.md](docs/02.input_validation.md).

### Section 3: CRUD Mutations & ref.listen

Learn how to extend a Riverpod `AsyncNotifier` with create, update, and delete operations using the `isMutating` lifecycle, and how to react to state transitions using `ref.listen` for navigation and notifications. Check [docs/03.mutations_and_ref_listen.md](docs/03.mutations_and_ref_listen.md).

### Section 4: Showcase App Walkthrough

Explore how all concepts are applied in the updated `my_store` application. Check [docs/04.my_store_walkthrough.md](docs/04.my_store_walkthrough.md).
