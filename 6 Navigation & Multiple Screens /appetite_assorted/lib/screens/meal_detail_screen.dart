import 'package:flutter/material.dart';

import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/meal/meal_details.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/meal-details';

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = FOOD_MEALS.firstWhere((meal) => meal.id == mealID);
    return Scaffold(
      appBar: buildAppBar(selectedMeal.title, context),
      body: MealDetails(selectedMeal),
      // bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar buildAppBar(String title, BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context)
            .appBarTheme
            .textTheme!
            .headline6!
            .copyWith(color: Colors.white),
      ),
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}
