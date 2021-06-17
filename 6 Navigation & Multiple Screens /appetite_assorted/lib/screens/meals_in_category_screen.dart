import 'package:appetite_assorted/models/meal.dart';
import 'package:flutter/material.dart';

import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/meal/size_config.dart';
import 'package:appetite_assorted/widgets/meal/meal_item_card.dart';

// Base widget for category screen.
class CategoryMeals extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
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

      displayedMeals = FOOD_MEALS
          .where((meal) => meal.categories.contains(categoryID))
          .toList();

      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(categoryTitle),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize * 2,
                  vertical: 15,
                ),
                child: GridView.builder(
                  itemCount: displayedMeals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing:
                        SizeConfig.orientation == Orientation.landscape
                            ? SizeConfig.defaultSize * 2
                            : 0,
                    childAspectRatio: 1.65,
                  ),
                  itemBuilder: (context, index) => MealCard(
                    meal: displayedMeals[index],
                    removeItem: _removeMeal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title),
    );
  }
}
