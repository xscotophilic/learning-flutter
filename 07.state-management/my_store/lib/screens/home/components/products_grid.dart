import 'package:flutter/material.dart';
import 'package:my_store/helpers/app_consts.dart';
import 'package:my_store/providers/products.dart';
import 'package:my_store/screens/home/components/item_card.dart';
import 'package:my_store/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.showOnlyFavs});

  final bool showOnlyFavs;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showOnlyFavs ? productsData.favItems : productsData.items;

    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Constants.kDefaultPadding,
        crossAxisSpacing: Constants.kDefaultPadding,
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
