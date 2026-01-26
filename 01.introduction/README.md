<p align="center">
  <img src="https://user-images.githubusercontent.com/47301282/119266192-734ab180-bc07-11eb-85be-bbf14000cbf6.png" alt="Getting started with flutter"/>
</p>

1. [Installing Flutter](https://flutter.dev/docs/get-started/install)
2. Updating Flutter path [For Linux](https://flutter.dev/docs/get-started/install/linux#update-your-path), [For mac](https://flutter.dev/docs/get-started/install/macos#update-your-path), [For Windows](https://flutter.dev/docs/get-started/install/windows#update-your-path).
3. Creating New App using terminal. Go to the directory where you want to save your project. Run below command in terminal/ cmd. 
```
$ flutter create helloworld
```
4. Editing contents of lib/main.dart in helloworld project.
```
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello_World',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Hello_World'),
        ),
        body: Center(
          child: Text('Her face a river. This is a curse, a blessing too.'),
        ),
      ),
    );
  }
}
```
5. Change directory to helloworld and Run your project
``` 
$ cd helloworld 
$ flutter run 
```
6. This will probably start App in browser. You can configure an emulator and run the app on it, or you may run the app on an Android or iOS smartphone.

- You can read about Flutter Introduction in details on provided links:

  - [Get-started with Flutter on flutter.dev](https://flutter.dev/docs/get-started)

  - [Write your first Flutter app on flutter.dev](https://flutter.dev/docs/get-started/codelab)