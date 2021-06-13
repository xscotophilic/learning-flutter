import 'package:flutter/material.dart';

import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/categories_home/category_card.dart';

// Mapping all categories on screen
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: FOOD_CATEGORIES
            .map(
              (category) => CategoryCardMain(
                category.id,
                category.title,
                category.color,
                AssetImage(category.image),
              ),
              // CategoryCardMain
            )
            .toList(),
      ),
    );
  }
}
