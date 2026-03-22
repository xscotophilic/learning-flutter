import 'package:appetite_assorted/helpers/app_consts.dart';
import 'package:appetite_assorted/helpers/data.dart';
import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/filters/filters_screen.dart';
import 'package:appetite_assorted/screens/home/home_screen.dart';
import 'package:appetite_assorted/screens/meal_details/meal_details_screen.dart';
import 'package:appetite_assorted/screens/meals_in_category/meals_in_category_screen.dart';
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
  List<Meal> _availableMeals = allMeals;
  final List<Meal> _favouriteMeals = [];

  Map<DietaryType, bool> _filters = DietaryType.values.asMap().map(
    (index, type) => MapEntry(type, false),
  );

  bool _isMealFav(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  void _toggleFavourites(String id) {
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == id);
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(allMeals.firstWhere((meal) => meal.id == id));
      });
    }
  }

  void _setFilters(Map<DietaryType, bool> updatedFilters) {
    final activeFilters = updatedFilters.entries.where((f) => f.value).toList();

    final filteredMeals = allMeals.where((meal) {
      for (final activeFilter in activeFilters) {
        if (!meal.dietaryTypes.contains(activeFilter.key)) {
          return false;
        }
      }
      return true;
    }).toList();

    setState(() {
      _filters = updatedFilters;
      _availableMeals = filteredMeals;
    });
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
