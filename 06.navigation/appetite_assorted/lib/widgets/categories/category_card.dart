import 'package:appetite_assorted/screens/meals_in_category_screen.dart';
import 'package:appetite_assorted/widgets/auto_fit_text.dart';
import 'package:appetite_assorted/widgets/categories/custom_shape_clipper.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.id,
    required this.title,
    required this.color,
    required this.image,
  });

  final String id;
  final String title;
  final Color color;
  final ImageProvider image;

  final _borderRadius = const BorderRadius.all(Radius.circular(12.0));

  void _selectCategory(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamed(CategoryMeals.routeName, arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: _borderRadius,
      child: InkWell(
        borderRadius: _borderRadius,
        splashColor: Theme.of(context).colorScheme.onSurface.withAlpha(30),
        onTap: () => _selectCategory(context),
        child: LayoutBuilder(
          builder: (context, constraints) {
            const singleSidePadding = 16.0;
            final size = constraints.maxHeight;

            return Stack(
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: const CustomShapeClipper(ClipType.semiCircle),
                    child: SizedBox(
                      width: size,
                      height: size,
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
                          Image(width: 32, height: 32, image: image),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AutoFitText(
                              text: title,
                              style: Theme.of(context).textTheme.bodyLarge,
                              availableHeight: size - (singleSidePadding * 2),
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
