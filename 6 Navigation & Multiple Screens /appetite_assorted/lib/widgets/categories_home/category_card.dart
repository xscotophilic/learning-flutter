import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appetite_assorted/const.dart';
import 'package:appetite_assorted/widgets/categories_home/category_main.dart';
import 'package:appetite_assorted/widgets/categories_home/custom_clipper.dart';

class CategoryCardMain extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final ImageProvider image;

  CategoryCardMain(
    this.id,
    this.title,
    this.color,
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        width: ((MediaQuery.of(context).size.width -
                (Constants.paddingSide * 2 + Constants.paddingSide / 2)) /
            2),
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          shape: BoxShape.rectangle,
          color: color,
        ),
        child: Material(
          child: InkWell(
            onTap: () => SelectCategory(context),
            splashColor: Theme.of(context).primaryColor,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                Positioned(
                  child: ClipPath(
                    clipper: MyCustomClipper(ClipType.semiCircle),
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black.withOpacity(0.04),
                      ),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            width: 32,
                            height: 32,
                            image: image,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              ],
            ),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  void SelectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return CategoryMeals(id, title);
        },
      ),
    );
  }
}
