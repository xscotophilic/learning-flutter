# Introduction

In this module, we will create our very first Flutter application, understand the basic project structure, and dissect the famous "Hello World" example.

Before we start, if you want to understand the basic concepts of Flutter, please read the [About Flutter](./about-flutter.md) document.

## What We'll Build

We will build a simple app that displays a welcome message on the screen. This introduces you to the core concepts of specific widgets and how a Flutter app launches.

## Step-by-Step Guide

### 1. Create a New App

To start a new project, we use the Flutter CLI command `flutter create`. Open your terminal, navigate to your project directory (like this repo's root), and run:

```bash
flutter create helloworld
```

This command generates all the necessary files for a Flutter project, including native code for Android (`android/`), iOS (`ios/`), web (`web/`), and desktop platforms.

### 2. The Code (`lib/main.dart`)

The entry point of every Flutter application is the `lib/main.dart` file. Open this file in your IDE and replace its contents with the following code:

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World Example'),
        ),
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
```

### 3. Understanding the Code

Let's break down what's happening above:

- **`main()`**: The main function is the entry point of the application.
- **`runApp(MyApp())`**: This tells Flutter to launch the app and mount the `MyApp` widget as the root of the widget tree.
- **`StatelessWidget`**: A widget that doesn't store any mutable state. It just describes what the UI should look like based on its configuration.
- **`MaterialApp`**: A convenience widget that wraps a number of widgets that are commonly required for Material Design applications.
- **`Scaffold`**: Implements the basic Material Design visual layout structure. It gives you slots for an `AppBar`, `body`, and more.
- **`Center` & `Text`**: These are basic widgets. `Center` positions its child in the middle, and `Text` displays a string of characters.

### 4. Run the Project

Make sure your emulator is running or your physical device is connected or this will run on local browser. Then run:

```bash
flutter run
```

You should see your app launch on your device!

### 5. Test the Project

To verify if widgets are appearing correctly, we can write automated tests.

Flutter provides a `test` directory for your tests. update the content of the `widget_test.dart` file that verifies our "Hello World" app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:helloworld/main.dart';

void main() {
  testWidgets('Hello World smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our app does not display 'Goodbye World!'.
    expect(find.text('Goodbye World!'), findsNothing);

    // Verify that our app displays 'Hello World!'.
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
```

**Run the tests**: To execute the tests, run:

```bash
flutter test
```
