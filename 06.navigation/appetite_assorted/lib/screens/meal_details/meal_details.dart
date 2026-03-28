import 'package:appetite_assorted/models/meal.dart';
import 'package:flutter/material.dart';

class MealDetails extends StatelessWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    if (isLandscape) {
      return Row(
        children: [
          SizedBox(
            height: double.infinity,
            width: mediaQuery.size.width * 0.35,
            child: _Image(assetPath: meal.assetPath),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
              child: _MealInfo(meal: meal),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: mediaQuery.size.height * 0.30,
          child: _Image(assetPath: meal.assetPath),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
            child: _MealInfo(meal: meal),
          ),
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.primary.withAlpha(100),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image.asset(assetPath, fit: BoxFit.scaleDown),
      ),
    );
  }
}

class _MealInfo extends StatelessWidget {
  const _MealInfo({required this.meal});

  final Meal meal;

  Widget _buildSectionTitle(String title, double fontSize) {
    return Center(
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  List<Column> _buildBulletedList({
    required List<String> items,
    required double fontSize,
  }) {
    return List.generate(items.length, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\u2022 ${items[index]}', style: TextStyle(fontSize: fontSize)),
          const SizedBox(height: 4),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double longestSide = mediaQuery.size.longestSide;
    return ListView(
      padding: const EdgeInsets.all(24),
      children: <Widget>[
        _buildSectionTitle('Ingredients', longestSide * 0.02),
        const SizedBox(height: 16),
        ..._buildBulletedList(
          items: meal.ingredients,
          fontSize: longestSide * 0.016,
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Steps', longestSide * 0.02),
        const SizedBox(height: 16),
        ..._buildBulletedList(items: meal.steps, fontSize: longestSide * 0.016),
      ],
    );
  }
}
