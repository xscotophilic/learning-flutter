import 'package:appetite_assorted/app_consts.dart';
import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/filters_screen.dart';
import 'package:appetite_assorted/screens/home_screen.dart';
import 'package:appetite_assorted/screens/meal_detail_screen.dart';
import 'package:appetite_assorted/screens/meals_in_category_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<DietaryType, bool> _filters = {
    DietaryType.glutenFree: false,
    DietaryType.vegan: false,
    DietaryType.vegetarian: false,
    DietaryType.lactoseFree: false,
  };

  List<Meal> _availableMeals = allMeals;
  final List<Meal> _favouriteMeals = [];

  void _setFilters(Map<DietaryType, bool> filteredData) {
    final activeFilters = filteredData.entries.where((f) => f.value).toList();

    final filtered = allMeals.where((meal) {
      for (final filter in activeFilters) {
        if (!meal.dietaryTypes.contains(filter.key)) {
          return false;
        }
      }
      return true;
    }).toList();

    setState(() {
      _filters = filteredData;
      _availableMeals = filtered;
    });
  }

  bool _isMealFav(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  void _toggleFavourites(String mealID) {
    final existingIndex = _favouriteMeals.indexWhere(
      (meal) => meal.id == mealID,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(allMeals.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetite Assorted',

      theme: AppConstants.primaryTheme(context),

      home: HomeScreen(favouriteMeals: _favouriteMeals),
      routes: {
        CategoryMeals.routeName: (ctx) {
          return CategoryMeals(availableMeals: _availableMeals);
        },
        MealDetailScreen.routeName: (ctx) {
          return MealDetailScreen(
            toggleFavouritesHandler: _toggleFavourites,
            isMealFav: _isMealFav,
          );
        },
        FiltersScreen.routeName: (ctx) {
          return FiltersScreen(
            currentFilters: _filters,
            setFiltersHandler: _setFilters,
          );
        },
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(favouriteMeals: _favouriteMeals),
        );
      },
    );
  }
}
