import 'package:appetite_assorted/screens/categories/custom_shape_clipper.dart';
import 'package:appetite_assorted/screens/meals_in_category/meals_in_category_screen.dart';
import 'package:appetite_assorted/screens/widgets/common/auto_fit_text.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.id,
    required this.title,
    required this.color,
    required this.imageProvider,
  });

  final String id;
  final String title;
  final Color color;
  final ImageProvider imageProvider;

  final _borderRadius = const BorderRadius.all(Radius.circular(12.0));

  void _selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealsInCategoryScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: _borderRadius,
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.onSurface.withAlpha(30),
        borderRadius: _borderRadius,
        onTap: () => _selectCategory(context),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const singleSidePadding = 16.0;
            final widgetHeight = constraints.maxHeight;

            return Stack(
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: CustomShapeClipper(
                      ClipType.semiCircle,
                      borderRadius: BorderRadius.only(
                        topLeft: _borderRadius.topLeft,
                      ),
                    ),
                    child: SizedBox(
                      width: widgetHeight,
                      height: widgetHeight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(singleSidePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image(
                            width: widgetHeight * 0.24,
                            height: widgetHeight * 0.24,
                            image: imageProvider,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AutoFitText(
                              text: title,
                              style: TextStyle(fontSize: widgetHeight * 0.15),
                              availableHeight:
                                  widgetHeight - (singleSidePadding * 2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
