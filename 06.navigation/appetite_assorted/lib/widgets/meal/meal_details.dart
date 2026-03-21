import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/meal/item_image.dart';
import 'package:flutter/material.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemImage(imgSrc: meal.assetPath),
        Expanded(child: ItemInfo(meal: meal)),
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        buildSectionTitle(context, 'Ingredients'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...itmslistMapper(items: meal.ingredients, passfontSize: 12),
          ],
        ),
        buildSectionTitle(context, 'Steps'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [...itmslistMapper(items: meal.steps, passfontSize: 14)],
        ),
      ],
    );
  }

  Widget buildSectionTitle(BuildContext context, String title) {
    return Column(
      children: [
        const SizedBox(height: 9),
        Center(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 9),
      ],
    );
  }

  List<Column> itmslistMapper({
    required List<String> items,
    required double passfontSize,
  }) {
    return items
        .map(
          (item) => Column(
            children: [
              Text('\u2022 $item', style: TextStyle(fontSize: passfontSize)),
              const SizedBox(height: 6),
            ],
          ),
        )
        .toList();
  }
}
