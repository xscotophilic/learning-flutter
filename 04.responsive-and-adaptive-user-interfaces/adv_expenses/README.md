<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/121357767-aef7b200-c94f-11eb-804e-894f79556f2e.png" alt="CEP"/>
</p>

Copy expenses project from previous section (3 Widgets). In this part we will improve UI and responsiveness.

---

- The app we created in the previous part was not responsive or adaptive. It was a colossal flop for both landscape mode and iOS. So, in this section, we will attempt to resolve these concerns. By determining whether the device is in landscape mode? If yes, we display a different UI than the portrait one. Components should be rendered based on the platform (ie. Android or iOS).

- We utilise mediaQuery.orientation to determine the device's orientation and display widgets accordingly.
  Platform.isIOS can also be used to check the platform, which can be imported from package 'dart:io'. As well as 'package:flutter/cupertino.dart' for generating iOS style widgets. For iOS, we use the Cupertino page, button, and appbar, and for Android, we use the Material widgets.

- How can you tell if your app is responsive and adaptive?

  - There is no other option but to use the trial and error method. You must run your code on a variety of devices.

---

- iOS demo:

  - Portrait mode:

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121333130-2587b600-c936-11eb-8b45-43e91240b354.gif" alt="iOS demo v"/>
  </p>

  - Landscape mode:

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121333127-24568900-c936-11eb-95d6-23eee30046d6.gif" alt="iOS demo h"/>
  </p>

- Android demo:

  - Portrait mode:

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121339217-e197af80-c93b-11eb-94d7-a02eaba8c7f9.gif" alt="Android demo h"/>
  </p>

  - Landscape mode:

  <p align="center">
    <img src="https://user-images.githubusercontent.com/47301282/121339224-e3617300-c93b-11eb-9461-8c52db738380.gif" alt="Android demo v"/>
  </p>
