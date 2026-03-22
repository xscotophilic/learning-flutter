import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/meal/meal_item_card.dart';
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
      return Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          itemCount: favouriteMeals.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 512,
            childAspectRatio: 2.25,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final meal = favouriteMeals[index];
            return MealCard(key: ValueKey(meal.id), meal: meal);
          },
        ),
      );
    }
  }
}
