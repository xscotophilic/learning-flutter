<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121355134-368ff180-c94d-11eb-937f-912185c5263f.png" alt="iOS demo v"/>
</p>

- The content is similar to water. The content should be available to all users, regardless of the device used to view it.

- `The responsive design` displays material dependent on the amount of screen space available.
  Responsive design is flexible and adapts to the size of the screen regardless of the target device.

- `Adaptive design` enables designers to take control of the design and build for numerous points of view.

- Flutter

  - Flutter allows you to create apps that self-adapt to the device’s screen size and orientation.

  - `Responsive Flutter app` : Use the MediaQuery.of() method in your build functions. This gives you the size, orientation, etc, of your current app. This is more useful if you want to make decisions based on the complete context rather than on just the size of your particular widget. Other useful widgets and classes for creating a responsive UI:

    1. AspectRatio
    2. FittedBox
    3. LayoutBuilder
    4. MediaQuery
    5. MediaQueryData
    6. OrientationBuilder

  - `Adaptive Flutter app` : When bringing your app to multiple platforms is how to adapt it to the various sizes and shapes of the screens that it will run on.

    - Device segmentation : There are times when you want to make layout decisions based on the actual platform you’re running on.

      ```
      bool get isMobileDevice => (Platform.isIOS || Platform.isAndroid);

      bool get isMobileDeviceOrWeb => isMobileDevice || kIsWeb;

      ```

    - Consider expected behavior on each platform : The first step is to spend some time considering what the expected appearance, presentation, or behavior is on this platform.

- You can read about `responsive and adaptive apps` in details on provided links:

  - [Creating responsive and adaptive apps](https://flutter.dev/docs/development/ui/layout/adaptive-responsive)
  - [Building adaptive apps](https://flutter.dev/docs/development/ui/layout/building-adaptive-apps)
