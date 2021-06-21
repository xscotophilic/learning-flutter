import 'package:flutter/material.dart';

import '../../../providers/product.dart';
import '../../../const.dart';
import '../../../data.dart';
import './products_grid.dart';

class Body extends StatelessWidget {
  final List<Product> products = PRODUCTS;

  Body({
    Key? key,
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
            child: productsGrid(),
          ),
        ),
      ],
    );
  }
}
