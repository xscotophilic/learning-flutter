import 'package:flutter/material.dart';

import 'package:appetite_assorted/data.dart';
import 'package:appetite_assorted/widgets/categories/category_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        padding: const EdgeInsets.all(30),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: foodCategories
            .map(
              (category) => CategoryCardMain(
                id: category.id,
                title: category.title,
                color: category.color,
                image: AssetImage(category.image),
              ),
              // CategoryCardMain
            )
            .toList(),
      ),
    );
  }
}
