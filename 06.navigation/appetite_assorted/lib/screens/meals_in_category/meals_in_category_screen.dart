import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/widgets/common/meals_grid_view.dart';
import 'package:flutter/material.dart';

class CategoryMeals extends StatelessWidget {
  const CategoryMeals({super.key, required this.availableMeals});

  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  AppBar _buildAppBar(String title) {
    return AppBar(title: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryID = args['id']?.toString();
    final categoryTitle = args['title']?.toString();

    final mealsInCategory = availableMeals.where((meal) {
      return meal.categories.contains(categoryID);
    }).toList();

    if (categoryID == null ||
        categoryID.isEmpty ||
        categoryTitle == null ||
        categoryTitle.isEmpty) {
      return Scaffold(
        appBar: _buildAppBar('Error'),
        body: const Center(
          child: Text('Something went wrong while passing data!'),
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(categoryTitle),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: MealsGridView(meals: mealsInCategory)),
          ],
        ),
      ),
    );
  }
}
