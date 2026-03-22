import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/widgets/common/meals_grid_view.dart';
import 'package:flutter/material.dart';

class FavoritesListView extends StatelessWidget {
  const FavoritesListView({super.key, required this.favouriteMeals});

  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text(
          'You have no favorites yet!',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      );
    } else {
      return MealsGridView(meals: favouriteMeals);
    }
  }
}
