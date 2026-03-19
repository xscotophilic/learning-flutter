import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/meal/meal_details.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({
    super.key,
    required this.isMealFav,
    required this.toggleFavouritesHandler,
  });

  static const routeName = '/meal-details';
  final bool Function(String) isMealFav;
  final Function toggleFavouritesHandler;

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = allMeals.firstWhere((meal) => meal.id == mealID);
    return Scaffold(
      appBar: buildAppBar(context, selectedMeal.title),
      body: MealDetails(meal: selectedMeal),
      // bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFav(mealID) ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          toggleFavouritesHandler(mealID);
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(elevation: 0, title: Text(title));
  }
}
