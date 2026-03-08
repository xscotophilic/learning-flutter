# Responsive & Adaptive User Interfaces

We'll see how to make our apps work across different screen sizes, from mobile to desktop, using responsive and adaptive design.

## Responsive vs. Adaptive

These two terms are related but distinct approaches to multi-device UI design.

| Approach       | Core Idea                                                                                                                              | Flutter Analogy                             |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------ |
| **Responsive** | The layout _fluidly reflows_ to fill the available space. Content is like water - it takes the shape of its container.                 | `LayoutBuilder`, `MediaQuery`, `FittedBox`  |
| **Adaptive**   | The layout makes _deliberate, platform-aware decisions_. Different platforms may show fundamentally different widgets or interactions. | `Platform.isIOS`, platform-specific widgets |

## Responsive Design in Flutter

A responsive Flutter app reads the current screen dimensions and adjusts its layout accordingly.

### Key Tools

| Widget / Class           | Purpose                                                                                   |
| :----------------------- | :---------------------------------------------------------------------------------------- |
| **`MediaQuery`**         | Provides the device's screen size, orientation, pixel density, and text scale factor.     |
| **`LayoutBuilder`**      | Provides the _parent widget's_ constraints, making it ideal for responsive child layouts. |
| **`AspectRatio`**        | Forces a child widget to maintain a specific width-to-height ratio.                       |
| **`FittedBox`**          | Scales and positions its child to fit within the available space.                         |
| **`OrientationBuilder`** | Rebuilds its subtree when the device orientation changes (portrait ↔ landscape).          |

### Example: Switching Layout on Orientation

```dart
OrientationBuilder(
  builder: (context, orientation) {
    return orientation == Orientation.portrait
        ? const Column(children: [ ... ])   // Stacked layout for portrait
        : const Row(children: [ ... ]);     // Side-by-side layout for landscape
  },
)
```

### Example: Reading Screen Size with `MediaQuery`

```dart
final screenWidth = MediaQuery.of(context).size.width;

// Show a sidebar only on wide screens
if (screenWidth > 600) {
  return const WideLayoutWithSidebar();
}
return const NarrowLayout();
```

> [!TIP]
> Prefer `LayoutBuilder` over `MediaQuery` when you want to respond to the _parent's_ constraints rather than the entire screen size. It makes your widget more reusable and composable.

## Adaptive Design in Flutter

An adaptive app goes further - it detects the _platform_ and renders platform-native behaviour. A toggle switch, for example, should look like a Cupertino switch on iOS and a Material switch on Android.

### Platform Detection

Use the `Platform` class from `dart:io` (for native platforms) or the `kIsWeb` constant to determine where your app is running:

```dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

bool get isMobileDevice => Platform.isIOS || Platform.isAndroid;
bool get isMobileDeviceOrWeb => isMobileDevice || kIsWeb;
```

> [!IMPORTANT]
> `dart:io` is not available on the web. Always guard `Platform` checks with `!kIsWeb`, or use a package like [`universal_platform`](https://pub.dev/packages/universal_platform) for cross-platform safety.

### Platform-Adaptive Widgets

Flutter provides several widgets with an `.adaptive` constructor that automatically renders the correct native control for the current platform:

- **`Switch.adaptive`**: Renders a `CupertinoSwitch` on iOS/macOS, and a Material `Switch` elsewhere.
- **`Slider.adaptive`**: Renders a Cupertino or Material slider depending on the platform.
- **`CircularProgressIndicator.adaptive`**: Shows the native loading indicator style.

```dart
// This single widget renders correctly on both iOS and Android
Switch.adaptive(
  value: _isEnabled,
  onChanged: (value) => setState(() => _isEnabled = value),
)
```

## Further Reading

- [Creating responsive and adaptive apps](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive)
- [Building adaptive apps](https://docs.flutter.dev/ui/layout/responsive/building-adaptive-apps)

## The "Expenses App" (Adaptive Edition)

The `expenses` folder contains an upgraded version of the Expenses app from Module 03 Widgets, refactored to be responsive and adaptive across phone and tablet screen sizes.

### What you'll learn from it:

- **`MediaQuery` for Layout Logic**: Used to detect orientation and screen height. The app switches between a "toggle" view in landscape (showing either chart or list) and a "stacked" view in portrait (showing both).
- **`LayoutBuilder` & `FittedBox`**: Demonstrates how to use parent constraints to scale images proportionally (`LayoutBuilder`) and ensure text fits within its container (`FittedBox`).
- **Platform-Aware UI**: Uses `Platform.isIOS` and `kIsWeb` to adjust the entire app structure, switching between `Scaffold` and `CupertinoPageScaffold`, and using platform-native components like `CupertinoSwitch` and `CupertinoNavigationBar`.
- **`AdaptiveFlatButton`**: A custom widget (`lib/widgets/adaptive_flat_button.dart`) that demonstrates how to manually wrap platform-specific buttons (`CupertinoButton` vs `TextButton`) for a consistent API.

### How to Run:

1. Change directory to `expenses`.
2. Run `flutter pub get` to fetch dependencies.
3. Run `flutter run` to launch it on your connected device or emulator.
