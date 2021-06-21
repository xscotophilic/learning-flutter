import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const.dart';
import './item_card.dart';
import '../../../providers/products.dart';
import '../../product_details/product_details.dart';

class productsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Constants.kDefaultPaddin,
        crossAxisSpacing: Constants.kDefaultPaddin,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ItemCard(
          onClickHandler: () => Navigator.of(context).pushNamed(
            ProductDetailsScreen.routeName,
            arguments: products[index].id,
          ),
        ),
      ),
    );
  }
}
