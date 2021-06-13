import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:appetite_assorted/const.dart';
import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/meal/size_config.dart';
import 'package:appetite_assorted/widgets/meal/meal_item.dart';

// Base widget for category screen.
class CategoryMeals extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    final categoryID = routeArgs['id'].toString();
    final categoryTitle = routeArgs['title'].toString();

    final filteredMeals = FOOD_MEALS
        .where((meal) => meal.categories.contains(categoryID))
        .toList();

    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context, categoryTitle),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.defaultSize * 2,
                  vertical: 15,
                ),
                child: GridView.builder(
                  itemCount: filteredMeals.length,
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
                    meal: filteredMeals[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, String title) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/back.svg",
          color: Constants.lightAccent,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/');
        },
      ),
      title: Text(title),
    );
  }
}
