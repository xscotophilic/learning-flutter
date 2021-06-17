import 'package:appetite_assorted/screens/filters_screen.dart';
import 'package:flutter/material.dart';

import 'package:appetite_assorted/const.dart';
import 'package:appetite_assorted/screens/home_screen.dart';
import 'package:appetite_assorted/screens/meals_in_category_screen.dart';
import 'package:appetite_assorted/screens/meal_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetite Assorted',

      // ------- Theme data starts -------
      theme: Constants.darkTheme(context),
      // ------- Theme data ends -------

      home: HomeScreen(), // Home page
      routes: {
        CategoryMeals.routeName: (ctx) => CategoryMeals(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
      },
      onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        );
      },
    );
  }
}
