import 'package:appetite_assorted/app_consts.dart';
import 'package:appetite_assorted/screens/meals_in_category_screen.dart';
import 'package:appetite_assorted/widgets/categories/custom_clipper.dart';
import 'package:flutter/material.dart';

class CategoryCardMain extends StatelessWidget {
  const CategoryCardMain({
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

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        // margin: const EdgeInsets.only(right: 15.0),
        width:
            ((MediaQuery.of(context).size.width -
                (AppConstants.defaultPadding * 2 +
                    AppConstants.defaultPadding / 2)) /
            2),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          color: color,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => selectCategory(context),
            splashColor: Theme.of(context).primaryColor,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: const MyCustomClipper(ClipType.semiCircle),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.black.withAlpha(10),
                      ),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image(width: 32, height: 32, image: image),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectCategory(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamed(CategoryMeals.routeName, arguments: {'id': id, 'title': title});
  }
}
