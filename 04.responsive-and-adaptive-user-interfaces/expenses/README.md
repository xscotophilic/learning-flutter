# Expenses App (Responsive & Adaptive)

An enhanced version of the expense tracker app demonstrating responsive layout design and platform-adaptive UI across iOS, Android, and web. It handles dynamic screen dimensions, landscape/portrait orientations, device notches with `SafeArea`, and platform-native widgets (Material vs Cupertino).

## Quick Start

### Run the App

```bash
flutter run
```

### Run Tests

```bash
flutter test
```

## Project Structure

- `lib/main.dart` - Application entry point configuring theme palettes, custom text themes, and scaffold structure.
- `lib/home_page.dart` - Responsive screen utilizing `MediaQuery` to adapt layouts between portrait and landscape modes, and conditionally rendering Material or Cupertino navigation bars and switches.
- `lib/models/` - Data models:
  - `transaction.dart` - Model representing an individual transaction item (ID, title, amount, and date).
- `lib/widgets/` - Adaptive and responsive UI components:
  - `adaptive_flat_button.dart` - Cross-platform button rendering Cupertino or Material text buttons based on platform.
  - `chart.dart` - Weekly expense bar chart adapting its height to available screen dimensions.
  - `chart_bar.dart` - Individual day bar using `LayoutBuilder` to size labels and progress bars proportionally.
  - `new_transaction.dart` - Adaptive bottom sheet form with platform-aware inputs, date pickers, and keyboard avoidance.
  - `transaction_list.dart` - Responsive list view with adaptive delete controls and empty state illustrations.
- `test/widget_test.dart` - Basic widget smoke test for the app.
