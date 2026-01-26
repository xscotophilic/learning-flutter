import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/meal/meal_details.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-details';
  final Function toggleFavouritesHandler;
  final Function isMealFav;
  const MealDetailScreen({
    Key? key,
    required this.toggleFavouritesHandler,
    required this.isMealFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = FOOD_MEALS.firstWhere((meal) => meal.id == mealID);
    return Scaffold(
      appBar: buildAppBar(
        context,
        selectedMeal.title,
      ),
      body: MealDetails(selectedMeal),
      // bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isMealFav(mealID) ? Icons.favorite : Icons.favorite_border,
        ),
        onPressed: () {
          toggleFavouritesHandler(mealID);
        },
      ),
    );
  }

  AppBar buildAppBar(
    BuildContext context,
    String title,
  ) {
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
