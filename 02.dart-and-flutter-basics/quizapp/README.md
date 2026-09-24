# Quiz App

An interactive quiz application demonstrating Flutter fundamentals, including stateful and stateless widgets, callback handlers, conditional rendering, and passing data between custom widgets.

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

- `lib/main.dart` - Entry point configuring the app structure and defining sample quiz questions with answers and scores.
- `lib/home_content.dart` - Main stateful component managing the current question index, total score tracking, and restart logic.
- `lib/widgets/` - Reusable modular UI components:
  - `quiz.dart` - Coordinates the display of questions and answer options.
  - `question.dart` - Formatted question text widget.
  - `answer.dart` - Custom styled answer button widget.
  - `result.dart` - Score summary screen with personalized feedback and reset button.
- `test/widget_test.dart` - Basic widget smoke test for the app.
