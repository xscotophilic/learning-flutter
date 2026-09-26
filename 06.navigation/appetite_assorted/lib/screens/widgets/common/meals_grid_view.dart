import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/widgets/common/meal_card.dart';
import 'package:flutter/material.dart';

class MealsGridView extends StatelessWidget {
  const MealsGridView({super.key, required this.meals});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GridView.builder(
        itemCount: meals.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 512,
          childAspectRatio: 2.25,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final meal = meals[index];
          return MealCard(key: ValueKey(meal.id), meal: meal);
        },
      ),
    );
  }
}
