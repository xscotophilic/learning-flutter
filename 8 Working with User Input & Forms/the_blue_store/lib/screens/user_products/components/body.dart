import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/products.dart';
import './user_product_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return ListView.builder(
      itemCount: productsData.items.length,
      itemBuilder: (_, index) => Column(
        children: [
          UserProductItem(
            id: productsData.items[index].id,
            title: productsData.items[index].title,
            imageURL: productsData.items[index].imageURL,
            productColor: productsData.items[index].color,
          ),
          SizedBox(
            height: 3,
          )
        ],
      ),
    );
  }
}
