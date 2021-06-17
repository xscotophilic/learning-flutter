import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:appetite_assorted/widgets/meal/size_config.dart';
import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/meal_detail_screen.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final Function removeItem;

  MealCard({
    required this.meal,
    required this.removeItem,
  });

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Luxurious:
        return 'Luxurious';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;

    return InkWell(
      onTap: () => selectMeal(context, meal.id),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      meal.title,
                      style: TextStyle(
                        fontSize: defaultSize * 2.2, //22
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    buildInfoRow(
                      defaultSize,
                      iconSrc: "assets/icons/meals/time.svg",
                      text: "${meal.duration} mins",
                    ),
                    SizedBox(height: defaultSize * 0.7), //5
                    buildInfoRow(
                      defaultSize,
                      iconSrc: "assets/icons/meals/complexity.svg",
                      text: "${complexityText}",
                    ),
                    SizedBox(height: defaultSize * 0.7), //5
                    buildInfoRow(
                      defaultSize,
                      iconSrc: "assets/icons/meals/money.svg",
                      text: "${affordabilityText}",
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize), //5
            AspectRatio(
              aspectRatio: 0.6,
              child: Image.network(
                meal.imageURL,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectMeal(BuildContext context, String id) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then(
      (value) {
        if (value != null) {
          removeItem(value);
        }
      },
    );
  }

  Row buildInfoRow(double defaultSize, {required String iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          iconSrc,
          width: 20,
          height: 20,
        ),
        SizedBox(width: defaultSize), // 10
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
