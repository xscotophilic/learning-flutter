# Learning Flutter

This project is a comprehensive collection of modules and practical examples designed to guide you through the journey of mastering Flutter and Dart-from the absolute basics to advanced app development techniques.

## Curriculum

The repository is organized into sequential learning modules. Each folder focuses on a specific key concept in Flutter development:

| Module | Topic                       | Description                                                                                          |
| :----- | :-------------------------- | :--------------------------------------------------------------------------------------------------- |
| 01     | **Introduction**            | Getting started with the Flutter echosystem and your first "Hello World" app.                        |
| 02     | **Dart and Flutter Basics** | Understanding the Dart language, widget tree, basic layout, and the core building blocks of UI.      |
| 03     | **Widgets**                 | A deeper look into stateless and stateful widgets, and styling your apps.                            |
| 04     | **Responsive UI**           | Building adaptive user interfaces that look great on different screen sizes and orientations.        |
| 05     | **Flutter Deep Dive**       | Exploring internal mechanics and advanced configuration options.                                     |
| 06     | **Navigation**              | Managing multiple screens, passing data, and understanding the navigation stack.                     |
| 07     | **State Management**        | practical guides to managing app state effectively (Riverpod, etc.).                                 |
| 08     | **Forms & User Input**      | Handling user input, validation, and form submission.                                                |
| 09     | **HTTP Requests**           | Connecting your app to the internet, fetching data, and handling APIs.                               |
| 10     | **Authentication**          | Implementing user login, and secure sessions.                                                        |
| 11     | **Extras**                  | Auxiliary backend services and APIs (e.g., `mystore-backend`) supporting full-stack app integration. |

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
5. **Setup**:
   - **Code Generation (Optional)**: If the module uses code generation, run:
     ```bash
     dart run build_runner build --delete-conflicting-outputs
     ```
   - **Additional Configuration**: Some modules require setting up local parameters (e.g., API keys, OAuth IDs, server URLs, or `.env` configs). Please refer to the module's `README.md` before running the app.
6. **Running the app**: To run an application on an emulator or connected device:
   ```bash
   flutter run
   ```
   If you have multiple devices connected, you can specify one:
   ```bash
   flutter run -d <device-id>
   ```

## Important Notes

> **Font & Asset Usage**: All fonts and assets used in this repository are open-source. If you spot any commercial font references or proprietary assets in a module's `pubspec.yaml` or `assets` folder, please replace them with open-source alternatives or report them to avoid build errors and licensing issues.

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
