import 'package:appetite_assorted/helpers/data.dart';
import 'package:appetite_assorted/screens/categories/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesGridView extends StatelessWidget {
  const CategoriesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 256,
          childAspectRatio: 1.5,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        children: foodCategories.map((category) {
          return CategoryCard(
            key: ValueKey(category.id),
            id: category.id,
            title: category.title,
            color: category.color,
            imageProvider: AssetImage(category.assetPath),
          );
        }).toList(),
      ),
    );
  }
}
