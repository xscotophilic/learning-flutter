import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/widgets/common/meals_grid_view.dart';
import 'package:flutter/material.dart';

class CategoryMeals extends StatefulWidget {
  const CategoryMeals({super.key, required this.availableMeals});

  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  @override
  State<CategoryMeals> createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryID = routeArgs['id'].toString();
      categoryTitle = routeArgs['title'].toString();

      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryID))
          .toList();

      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  AppBar _buildAppBar(String title) {
    return AppBar(title: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(categoryTitle),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: MealsGridView(meals: displayedMeals)),
          ],
        ),
      ),
    );
  }
}
