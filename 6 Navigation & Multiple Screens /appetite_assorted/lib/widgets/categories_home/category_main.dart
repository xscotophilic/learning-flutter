import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:appetite_assorted/const.dart';

// Base widget for category screen.
class CategoryMeals extends StatelessWidget {
  final String categoryID;
  final String categoryTitle;

  const CategoryMeals(this.categoryID, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/back.svg",
          color: Constants.lightAccent,
        ),
        onPressed: () {},
      ),
      title: Text(categoryTitle),
    );
  }
}
