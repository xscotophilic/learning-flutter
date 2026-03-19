import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/meal/meal_item_card.dart';
import 'package:appetite_assorted/widgets/meal/size_config.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.favouriteMeals});

  final List<Meal> favouriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return const Center(child: Text('You have no favorites yet!'));
    } else {
      return Container(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: favouriteMeals.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: SizeConfig.orientation == Orientation.landscape
                ? 2
                : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: SizeConfig.orientation == Orientation.landscape
                ? SizeConfig.defaultSize * 2
                : 0,
            childAspectRatio: 1.65,
          ),
          itemBuilder: (context, index) =>
              MealCard(meal: favouriteMeals[index]),
        ),
      );
    }
  }
}
