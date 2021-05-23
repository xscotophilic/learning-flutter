<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119260208-68842280-bbef-11eb-89bf-e86b9e967e89.png" alt="dart"/>
</p>

- Dart is a client-optimized language for fast apps on any platform.

- Dart as a language, is very robust. Having been created by Google, its primary purpose was to leverage C-based Object Oriented Programming languages like C#, and Java. As it is also a general-purpose programming language, it compiles fast and is concise.

---

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119260209-69b54f80-bbef-11eb-9dc5-74c142d30da6.png" alt="Flutter"/>
</p>

- Flutter is an open-source UI software development kit created by Google. It is used to develop cross platform applications for Android, iOS, Linux, Mac, Windows, Google Fuchsia, and the web from a single codebase.

- Flutter is an open-source mobile SDK (Software Development Kit). An SDK or devkit functions in much the same way, providing a set of tools, libraries, relevant documentation, code samples, processes, and or guides that allow developers to create software applications on a specific platform. SDK: Tools to compile your code to native machine code + develop with ease.

- It is used to develop cross platform applications from a single codebase. A codebase is a source code repository or a set of repositories that share a common root, Here we do not need to write different code for IOS and ANDROID to run a same App.

- In flutter, App's UI is a Widget Tree! The widget tree is how you create your UI; you position widgets within each other to build simple and complex layouts. A smart approach is to attempt and maintain the widget tree as shallow as possible.

Flutter and Dart

<p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/119261049-307ede80-bbf3-11eb-82aa-1787d163d6ad.png" alt="Flutter and Dart"/>
</p>

## Architecture of Flutter

> Flutter is designed as an extensible, layered system. It exists as a series of independent libraries that each depend on the underlying layer. No layer has privileged access to the layer below, and every part of the framework level is designed to be optional and replaceable.

<p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/119260348-0677ed00-bbf0-11eb-8531-e7cbbe611530.png" alt="archdiagram"/>
</p>

To the underlying operating system, Flutter applications are packaged in the same way as any other native application.

1. A platform-specific embedder provides an entrypoint; coordinates with the underlying operating system for access to services like rendering surfaces, accessibility, and input; and manages the message event loop. The embedder is written in a language that is appropriate for the platform: currently Java and C++ for Android, Objective-C/Objective-C++ for iOS and macOS, and C++ for Windows and Linux. Using the embedder, Flutter code can be integrated into an existing application as a module, or the code may be the entire content of the application. Flutter includes a number of embedders for common target platforms, but other embedders also exist.

2. At the core of Flutter is the Flutter engine, which is mostly written in C++ and supports the primitives necessary to support all Flutter applications. The engine is responsible for rasterizing composited scenes whenever a new frame needs to be painted. It provides the low-level implementation of Flutter’s core API. The engine is exposed to the Flutter framework through dart:ui, which wraps the underlying C++ code in Dart classes.

3. Typically, developers interact with Flutter through the Flutter framework, which provides a modern, reactive framework written in the Dart language. It includes a rich set of platform, layout, and foundational libraries, composed of a series of layers.

by Google.

## How is Flutter/ Dart "transformed" to a Native App?

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119261373-b64f5980-bbf4-11eb-9b63-aeb0d9842b18.png" alt="transformed"/>
</p>

Image source: https://academind.com/


---

### If you enjoy my work, You can help me with donation on

<a href="https://www.buymeacoffee.com/xscotophilic" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-red.png" alt="Buy Me A Coffee" height="30"/></a> or <a href="https://www.patreon.com/xscotophilic" target="_blank"><img src="https://img.shields.io/badge/Patreon-F96854?style=for-the-badge&logo=patreon&logoColor=white" alt="patreon" height="30"/></a>

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119249633-c268f600-bbb7-11eb-8f83-113142958427.png" alt="Thankyou!"/>
</p>