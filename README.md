# Learning Flutter

This project is a comprehensive collection of modules and practical examples designed to guide you through the journey of mastering Flutter and Dart-from the absolute basics to advanced app development techniques.

## Curriculum

The repository is organized into sequential learning modules. Each folder focuses on a specific key concept in Flutter development:

| Module | Topic                       | Description                                                                                     |
| :----- | :-------------------------- | :---------------------------------------------------------------------------------------------- |
| 01     | **Introduction**            | Getting started with the Flutter echosystem and your first "Hello World" app.                   |
| 02     | **Dart and Flutter Basics** | Understanding the Dart language, widget tree, basic layout, and the core building blocks of UI. |
| 03     | **Widgets**                 | A deeper look into stateless and stateful widgets, and styling your apps.                       |
| 04     | **Responsive UI**           | Building adaptive user interfaces that look great on different screen sizes and orientations.   |
| 05     | **Flutter Deep Dive**       | Exploring internal mechanics and advanced configuration options.                                |
| 06     | **Navigation**              | Managing multiple screens, passing data, and understanding the navigation stack.                |
| 07     | **State Management**        | practical guides to managing app state effectively (Provider, etc.).                            |
| 08     | **Forms & User Input**      | Handling user input, validation, and form submission.                                           |
| 09     | **HTTP Requests**           | Connecting your app to the internet, fetching data, and handling APIs.                          |
| 10     | **Authentication**          | Implementing user signup, login, and secure sessions.                                           |
| 11     | **Animations**              | Adding polish to your app with implicit and explicit animations.                                |
| 12     | **Native Features**         | Accessing device capabilities like the camera, location services, and storage.                  |

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install): Version mentioned in pubspec.yaml files in each module.
- [Dart SDK](https://dart.dev/get-dart): Usually included with Flutter (No extra installation needed).
- An IDE (VS Code, Android Studio, or IntelliJ IDEA) with the Flutter/Dart plugins installed.

### How to Run the Project

1. **Clone the repository**:
   ```bash
   git clone https://github.com/xscotophilic/learning-flutter.git
   cd learning-flutter
   ```
2. **Navigate to a module**: Choose the module you are interested in. For example:
   ```bash
   cd 01.introduction
   ```
3. **README**: Read the README.md file in the module.
4. **Install dependencies**: You'll need to fetch the packages for the specific project you are running:
   ```bash
   flutter pub get
   ```
5. **Running the app**: To run an application on an emulator or connected device:
   ```bash
   flutter run
   ```
   If you have multiple devices connected, you can specify one:
   ```bash
   flutter run -d <device-id>
   ```

## Important Notes

> **Font Usage**: Some projects in this repository may reference commercial font families in their `pubspec.yaml` file. For public distribution or strict open-source usage, please remove these references or replace them with open-source alternatives to avoid build errors or licensing issues.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
