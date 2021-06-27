import 'package:flutter/material.dart';

import '../../../const.dart';
import './products_grid.dart';

class Body extends StatelessWidget {
  final bool showOnlyFavs;

  Body({
    Key? key,
    required this.showOnlyFavs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(
              Constants.kDefaultPaddin,
            ),
            child: productsGrid(showOnlyFavs),
          ),
        ),
      ],
    );
  }
}
