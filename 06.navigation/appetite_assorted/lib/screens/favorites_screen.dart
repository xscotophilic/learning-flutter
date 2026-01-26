import 'package:appetite_assorted/widgets/meal/meal_item_card.dart';
import 'package:appetite_assorted/widgets/meal/size_config.dart';
import 'package:flutter/material.dart';

import 'package:appetite_assorted/models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  const FavoritesScreen({Key? key, required this.favouriteMeals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet!'),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: favouriteMeals.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                SizeConfig.orientation == Orientation.landscape ? 2 : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: SizeConfig.orientation == Orientation.landscape
                ? SizeConfig.defaultSize * 2
                : 0,
            childAspectRatio: 1.65,
          ),
          itemBuilder: (context, index) => MealCard(
            meal: favouriteMeals[index],
          ),
        ),
      );
    }
  }
}
