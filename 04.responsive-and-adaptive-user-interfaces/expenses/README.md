# Expenses App

A personal expense tracker application demonstrating intermediate Flutter widget concepts, theme customization, list rendering, modal bottom sheets, form input handling, date pickers, and custom chart bars.

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

- `lib/main.dart` - Application entry point configuring theme data, custom text themes, and primary color schemes.
- `lib/home_page.dart` - Main stateful screen managing transactions, computing 7-day spending, and handling modal sheet display for new transactions.
- `lib/models/` - Data models:
  - `transaction.dart` - Defines the `Transaction` entity with ID, title, amount, and date.
- `lib/widgets/` - Reusable UI components:
  - `chart_bar.dart` - Visual bar representation of spending percentage per day.
  - `chart.dart` - Top summary widget calculating daily spending distribution over the past 7 days.
  - `new_transaction.dart` - Bottom sheet modal form with inputs for title, amount, and date selection.
  - `transaction_list.dart` - Scrollable list displaying transaction cards with delete actions or an empty state illustration.
- `test/widget_test.dart` - Basic widget smoke test for the app.
