<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/123061551-5e8d5380-d429-11eb-9086-a1fbccc257e7.png" alt="State Management in Flutter using Provider"/>
</p>

> Note: Because I utilised commercial font-families, I won't be able to upload it here. Please modify/remove font families from `pubspec.yaml` and Theme in `Main.dart`. Simply remove the font family lines and `Follow Commits to track progress of build`.

- The data that your application needs to show or do something with is called state. Data that is subject to change.

- We could utilise Flutter's Stateful widgets and call setState() to rebuild the widget after changing some data or state in `very basic cases when the application comprises of a single screen`. Remember that Flutter uses a reactive model, which means that it renders the user interface in reaction to changes in the state.

- As you learn more about Flutter, you'll find yourself needing to share application state between screens, across your app.
  It becomes considerably more difficult to transmit data from one widget to another, and from there to somewhere else.

- If you’re coming to Flutter from an imperative framework (such as Android SDK or iOS UIKit), you need to start thinking about app development from a new perspective [(More details here)](https://flutter.dev/docs/development/data-and-backend/state-mgmt). In Flutter it’s okay to rebuild parts of your UI from scratch instead of modifying it. Flutter is fast enough to do that, even on every frame if needed. Flutter is declarative. This means that Flutter builds its user interface to reflect the current state of your app.

1. Ephemeral state

- Ephemeral state (sometimes called UI state or local state) is the state you can neatly contain in a single widget.

2. App state

- State that is not ephemeral, that you want to share across many parts of your app, and that you want to keep between user sessions, is what we call application state (sometimes also called shared state).

- Examples of application state:

  - User preferences
  - Login info

<p>
  <img src="https://user-images.githubusercontent.com/47301282/123061548-5df4bd00-d429-11eb-8fcd-2b3480ff6d61.png" alt="List of state management approaches"/>
</p>

1. Provider
2. setState
3. InheritedWidget & InheritedModel
4. Redux
5. [etc.](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)

<p>
  <img src="https://user-images.githubusercontent.com/47301282/123061562-5fbe8080-d429-11eb-8d68-20520a93f45c.png" alt="Using Provider for State Management"/>
</p>

- The provider is mostly used to manage state in flutter. It is made up of four components.

  1. A model is a class that you construct to encapsulate your application's data and provide ways for changing it. This is what other widgets have access to. Consider it a product we will use in product screen, fav screen.

  2. Change Notifier: It is a central point that manages state of the screen. If the state inside it gets changed, then it notifies the framework to rebuilt the screen again.

  3. Change Notifier Provider: provides an instance of ChangeNotifier in the view.

  4. Consumer: is a widget that allows us to use the ChangeNotifier. When you want to Update the only Text Widget part when state changes insted of whole Material App/ Scaffold App/ big outer widget.

- We use Product provider here to update state it extends ChangeNotifier and notifies every component which uses this Product item. Instances of Product class are used to create objects.

```
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
```

- In the above code when we toggle the fav it notifies every widget which uses Product object.

<p>
  <img src="https://user-images.githubusercontent.com/47301282/123061559-5fbe8080-d429-11eb-9ac3-437ae6c0739e.png" alt="Summary" />
</p>

- State management in Flutter is a complicated issue, not least because there are so many different techniques and packages.

- I've tried to introduce the reader to Provider and its principles, as well as show how to include it into an application to exchange state between displays.

---

- You can read about `State management` in details on provided links:

  - [Managing Flutter State using Provider by Kenneth Carey](https://medium.com/flutter-community/managing-flutter-state-using-provider-e26c78060c26)
  - [State mgmt by fluter](https://flutter.dev/docs/development/data-and-backend/state-mgmt)
