# Navigation & Multiple Screens

> Note: Because I utilised commercial font-families, I won't be able to upload it here. Please modify/remove font families from `pubspec.yaml` and Theme in `Main.dart`. Simply remove the font family lines.

- Sorry I did wrong naming for below commits:

  - `S5 Flutter Deep dive 1.3.8 -> S6 Nav 1.3.8`
  - `S5 Flutter Deep dive 1.3.9 -> S6 Nav 1.3.9`
  - `S5 Flutter Deep dive 1.4.0 -> S6 Nav 1.4.0`

### Navigation

- Everything is a widget in Flutter including the multi page applications. It is built with container widgets (e.g. MaterialApp) which displays different home screens based on the navigation and user choices.

- Creating routes for navigation and Using Navigator.push() and Navigator.pop() for navigation. [Click here for Basic Example](https://flutter.dev/docs/cookbook/navigation/)

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/122517411-9bbea380-d02d-11eb-922f-ea2b94f240b7.gif" alt="Navigation"/>
</p>

- `main.dart` is entry point for every flutter app.

- `main.dart` contains material app which can be useful for navigation. Let us have 2 pages called `home.dart` and `favs.dart` created. Both of this files returns scaffold widgets. The easiest method to change the screen is by using Navigator.push() and Navigator.pop()', assuming `home.dart` returns **HomePage** widget and `favs.dart` returns **FavsPage**. main.dart ensures which page to show initially (if you are using materialapp widget then by setting `home:` property of it). home.dart contains button, where clicking that button will navigate to favs. Simply you add below code in `onPressed` function of button.

```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => FavsPage()),
);
```

This will navigate from Home screen to Favs.

- Advance way to navigate [named-routes](https://flutter.dev/docs/cookbook/navigation/named-routes) & [passing arguments](https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments).

### Drawer

- Material design mobile applications offer two major navigation choices. This is the Tabs and Drawers navigation. An alternate drawer for tabs is because the mobile applications often don't have enough room to accommodate tabs. drawer is a sliding left menu.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/122517393-96f9ef80-d02d-11eb-8702-fe90b7c0c435.gif" alt="Drawer"/>
</p>

- Some Useful Links:

  - [Adding a drawer](https://flutter.dev/docs/cookbook/design/drawer), [More on drawer](https://api.flutter.dev/flutter/material/Drawer-class.html).

  - [Official video by flutter](https://www.youtube.com/watch?v=WRj86iHihgY)

### Bottom bar

- Multiple elements such as text labels, icons or either can be found under the flutter navigation bar. This gives the user the opportunity to browse rapidly between the top views of an app. It is advisable to have a secondary navigation bar if we use a bigger screen.

  - In the bottom navigation we can only display a minimal number of widgets which can be 2-5.
  - At least two lower navigation elements must be present. If not, we'll receive a mistake.
  - The icon and the title attributes are necessary, and we must specify the appropriate widgets for them.

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/122517387-95302c00-d02d-11eb-99ac-1301036da626.gif" alt="Bottom Bar"/>
</p>

- Some Useful Links:

  - [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html).
