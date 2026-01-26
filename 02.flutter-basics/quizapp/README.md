# Quizapp

<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119799380-a0de7600-bef9-11eb-8744-1e2099042f40.gif" alt="Quizapp" height="480px"/>
</p>

## It's hard to document everything I code. So I've tried my best and explained things.

---

### Create a new Flutter project using:

```
flutter create quizapp
```

---

### Start with basics:

Edit lib/main.dart

```
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Text('Her face a river.')
    );
  }
}
```

1. Flutter app is nothing other than widgets, and we can use material design to develop Flutter widgets. So with import statement we can use material libirary.

2. When the programme starts, the main function is run by default. The runApp() function takes the given Widget and makes it the root of the widget tree. In our case it takes MyApp and makes it root widget.

3. Here, MyApp is named as the name of the stateless widget and extends a stateless widget. A build function is overwritten within this MyApp and BuildContext is taken as an argument. This BuildContext is the only one needed to find the widget within the widget tree for each widget.
   - The build function has a container that is another Flutter widget within which the application user interface is designed. The construct function is run in the statesless widget only one time, making the screen user interface.

   - A stateless widget is a widget that describes part of the user interface by building a constellation of other widgets that describe the user interface more concretely.

4. In any event, the MaterialApp widget is the means to follow the Material Design guidelines in Flutter.

5. home in MaterialApp: This is the route that is displayed first when the application is started normally, unless initialRoute is specified. It's also the route that's displayed if the initialRoute can't be displayed.

6. The Text widget displays a string of text with single style.

---

### Stateful and stateless widgets

- If a widget can change-when a user interacts with it, for example-it’s stateful. A stateless widget never changes. Icon, IconButton, and Text are examples of stateless widgets.

- You may read about Stateful and stateless widgets in depth on the links given:
  - [Creating a stateful widget](https://flutter.dev/docs/development/ui/interactive#stateful-and-stateless-widgets)

  - [Also, How to change app icon?](https://pub.dev/packages/flutter_launcher_icons)

---

### Creating a custom widget:

#### Suppose we have main.dart file as given below.

```
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Hello World!"));
  }
}
```

#### And when we write more code for Container, it will become larger and larger, thus we should build it as a custom widget for clear code and better interpretation. Example of refactoring is given below.

`1. Create new file helloworld.dart`

```
import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Hello World!"));
  }
}
```

`2. Replace code of main.dart`

```
import 'package:flutter/material.dart';

import './helloworld.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

---

### Focusing on logic and functions:

- Design logic for your application based on how you want it to behave. There is no other way to write and construct logic but via trial and error method.
