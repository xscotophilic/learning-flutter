import 'package:flutter/material.dart';

import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/widgets/meal/item_image.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;
  MealDetails(this.meal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ItemImage(
          imgSrc: meal.mainPageImageURL,
        ),
        Expanded(
          child: ItemInfo(meal),
        ),
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  final Meal meal;
  const ItemInfo(this.meal);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          BuildSectionTitle(context, 'Ingredients'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...itmslistMapper(items: meal.ingredients, passfontSize: 12),
            ],
          ),
          BuildSectionTitle(
            context,
            'Steps',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...itmslistMapper(
                items: meal.steps,
                passfontSize: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget BuildSectionTitle(BuildContext context, String title) {
    return Column(
      children: [
        SizedBox(height: 9),
        Center(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 25,
                  color: Theme.of(context).accentColor,
                ),
          ),
        ),
        SizedBox(height: 9),
      ],
    );
  }

  List<Column> itmslistMapper(
      {required List<String> items, required double passfontSize}) {
    return items
        .map(
          (item) => Column(
            children: [
              Text(
                '\u2022 ' + item,
                style: TextStyle(
                  fontSize: passfontSize,
                ),
              ),
              SizedBox(height: 6),
            ],
          ),
        )
        .toList();
  }
}
