# Dart and Flutter Basics

In this module, we explore the dart fundamentals and the core building blocks of Flutter development, from the syntax of Dart to the complex directory structures that make up a cross-platform application.

## Dart

Dart is designed to build smooth, high-performance UIs while keeping developer productivity high.

### Key Pillars

- **Object-Oriented**: Everything in Dart is an object. Numbers, functions, and even `null` are treated as objects, providing a consistent and powerful structure.
- **Strongly Typed**: Types help us catch bugs early. However, Dart is smart enough to use type inference (`var`) when the context is clear.
- **Sound Null Safety**: Dart ensures that variables don't contain `null` unless you explicitly allow it, preventing those annoying "null pointer" crashes in production.
- **JIT & AOT Compilation**:
  - **JIT (Just-in-Time)**: Powers "Hot Reload," allowing you to see code changes instantly during development.
  - **AOT (Ahead-of-Time)**: Compiles your code to fast machine code for production deployment.

> [!TIP]
> Want to experiment with Dart without setting up a local environment? Check out [DartPad](https://dartpad.dev/).

Before we go ahead, if you want to understand the basics of dart better, please read the [Learn Dart by Examples](./learn-dart-by-examples.md) document.

## Flutter

Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

### Decoding the Flutter Project Structure

When you create a Flutter project, it generates a lot of files. It can feel overwhelming at first, but each folder has a very specific "job."

| Folder / File                      | Purpose                                                                                               |
| :--------------------------------- | :---------------------------------------------------------------------------------------------------- |
| **`lib/`**                         | Where all your Dart code lives. You'll spend most of your time here writing features and UI.          |
| **`test/`**                        | Write your unit tests and widget tests here to verify your code works correctly.                      |
| **`pubspec.yaml`**                 | Manage your dependencies, assets (images, fonts), app metadata, and version numbers.                  |
| **`pubspec.lock`**                 | Auto-generated file that locks your dependency versions. Don't edit this manually.                    |
| **`android/` & `ios/`**            | Native Android and iOS projects. You'll modify these for platform permissions or native integrations. |
| **`linux/`, `macos/`, `windows/`** | Desktop platform projects. Handle platform-specific setup for running on computers.                   |
| **`web/`**                         | Web platform files. Contains the HTML entry point and web-specific configuration.                     |
| **`build/`**                       | Compiled output folder. Safe to delete - Flutter regenerates it automatically.                        |
| **`.dart_tool/`**                  | Internal Flutter tooling.                                                                             |
| **`analysis_options.yaml`**        | Configure linter rules and code analysis settings to maintain code quality.                           |
| **`.gitignore`**                   | Specifies which files Git should ignore to keep your repository clean.                                |
| **`.idea/` or `.vscode/`**         | IDE configuration files for Android Studio/IntelliJ or VS Code.                                       |
| **`README.md`**                    | Project documentation.                                                                                |

## The "Quiz App"

The `quizapp` folder contains a complete project that puts these basics into practice.

### What you'll learn from it:

- **Stateless vs. Stateful Widgets**: Understanding when a UI needs to change and how to manage that data.
- **Custom Widgets**: Breaking down a complex UI into small, reusable components (like `Quiz`, `Question`, and `Result`).
- **Lifting State Up**: How to pass data and callbacks between parent and child widgets.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119799380-a0de7600-bef9-11eb-8744-1e2099042f40.gif" alt="Quiz App Demo" height="400px"/>
</p>

### How to Run:

1. Change directory to `quizapp`.
2. Run `flutter pub get` to fetch dependencies.
3. Run `flutter run` to launch it on your connected device or emulator.
