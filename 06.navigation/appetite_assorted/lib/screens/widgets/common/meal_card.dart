import 'package:appetite_assorted/models/meal.dart';
import 'package:appetite_assorted/screens/meal_details/meal_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal});

  final Meal meal;

  BorderRadius get _borderRadius => BorderRadius.circular(12);

  String get _complexityText {
    switch (meal.complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
    }
  }

  String get _affordabilityText {
    switch (meal.affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.luxurious:
        return 'Luxurious';
      case Affordability.pricey:
        return 'Pricey';
    }
  }

  Row _buildInfoRow({
    required BuildContext context,
    required String assetPath,
    required String text,
    required double widgetHeight,
  }) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(
          assetPath,
          width: widgetHeight * 0.1,
          height: widgetHeight * 0.1,
        ),
        const SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: widgetHeight * 0.1)),
      ],
    );
  }

  void _selectMeal(BuildContext context, String id) {
    Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: _borderRadius,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.onPrimary.withAlpha(30),
        borderRadius: _borderRadius,
        onTap: () => _selectMeal(context, meal.id),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final widgetHeight = constraints.maxHeight;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          meal.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: widgetHeight * 0.16),
                        ),
                        const Spacer(),
                        const SizedBox(height: 4),
                        _buildInfoRow(
                          context: context,
                          assetPath: 'assets/icons/meals/duration.svg',
                          text: '${meal.duration} mins',
                          widgetHeight: widgetHeight,
                        ),
                        const SizedBox(height: 4),
                        _buildInfoRow(
                          context: context,
                          assetPath: 'assets/icons/meals/complexity.svg',
                          text: _complexityText,
                          widgetHeight: widgetHeight,
                        ),
                        const SizedBox(height: 4),
                        _buildInfoRow(
                          context: context,
                          assetPath: 'assets/icons/meals/affordability.svg',
                          text: _affordabilityText,
                          widgetHeight: widgetHeight,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),
              AspectRatio(
                aspectRatio: 0.75,
                child: Image.asset(
                  meal.assetPath,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
