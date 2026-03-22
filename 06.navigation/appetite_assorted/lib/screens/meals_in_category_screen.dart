import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/meal/meal_item_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(categoryTitle),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GridView.builder(
                  itemCount: displayedMeals.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 512,
                    childAspectRatio: 2.25,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final meal = displayedMeals[index];
                    return MealCard(key: ValueKey(meal.id), meal: meal);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(elevation: 0, title: Text(title));
  }
}
