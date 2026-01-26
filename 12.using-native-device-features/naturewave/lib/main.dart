import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './const.dart';
import './providers/great_places.dart';
import './screens/home/home_screen.dart';
import './screens/add_place/add_place_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GreatPlaces>(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'NatureWave',

        // ------- Theme data starts -------
        theme: Constants.lightTheme(context),
        // ------- Theme data ends -------

        home: HomeScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
