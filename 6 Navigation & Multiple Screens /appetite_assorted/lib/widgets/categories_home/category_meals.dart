import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:appetite_assorted/const.dart';

// Base widget for category screen.
class CategoryMeals extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // final categoryID = routeArgs['id'].toString();
    final categoryTitle = routeArgs['title'].toString();

    return Scaffold(
      appBar: buildAppBar(categoryTitle),
      body: Container(
        child: Center(
          child: Text(
            categoryTitle,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/back.svg",
          color: Constants.lightAccent,
        ),
        onPressed: () {},
      ),
      title: Text(title),
    );
  }
}
