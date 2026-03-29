import 'package:flutter/material.dart';
import 'package:my_store/const.dart';
import 'package:my_store/providers/product.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.kDefaultPadding * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: Constants.kDefaultPadding),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(text: 'Price\n'),
                    TextSpan(
                      text: '\$${product.price}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Constants.kDefaultPadding),
              Expanded(
                child: Hero(
                  tag: product.id,
                  child: Image.network(product.imageURL, fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
