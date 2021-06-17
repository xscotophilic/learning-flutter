import 'package:flutter/material.dart';

import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/const.dart';
import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/screens/home_screen.dart';
import 'package:appetite_assorted/screens/meals_in_category_screen.dart';
import 'package:appetite_assorted/screens/meal_detail_screen.dart';
import 'package:appetite_assorted/screens/filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'isGlutenFree': false,
    'isVegan': false,
    'isVegetarian': false,
    'isLactoseFree': false,
  };

  List<Meal> _availableMeals = FOOD_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filteredData) {
    setState(() {
      _filters = filteredData;

      _availableMeals = FOOD_MEALS.where(
        (meal) {
          if (_filters['isGlutenFree']! && !meal.isGlutenFree) {
            return false;
          }
          if (_filters['isVegan']! && !meal.isVegan) {
            return false;
          }
          if (_filters['isLactoseFree']! && !meal.isLactoseFree) {
            return false;
          }
          if (_filters['isVegetarian']! && !meal.isVegetarian) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetite Assorted',

      // ------- Theme data starts -------
      theme: Constants.darkTheme(context),
      // ------- Theme data ends -------

      home: HomeScreen(favouriteMeals: _favouriteMeals), // Home page
      routes: {
        CategoryMeals.routeName: (ctx) => CategoryMeals(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              toggleFavouritesHandler: _toggleFavourites,
              isMealFav: _isMealFav,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              currentFilters: _filters,
              setFiltersHandler: _setFilters,
            ),
      },
      onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(favouriteMeals: _favouriteMeals),
        );
      },
    );
  }

  void _toggleFavourites(String mealID) {
    final existingIndex =
        _favouriteMeals.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(FOOD_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  bool _isMealFav(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }
}
