import 'package:flutter/material.dart';
import 'package:my_store/const.dart';
import 'package:my_store/providers/product.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.kDefaultPadding),
      child: Text(product.description, style: const TextStyle(height: 1.5)),
    );
  }
}
