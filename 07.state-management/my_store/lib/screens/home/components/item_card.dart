import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_store/helpers/app_consts.dart';
import 'package:my_store/providers/cart.dart';
import 'package:my_store/providers/product.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.onClickHandler});

  final Function onClickHandler;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    final cart = Provider.of<Cart>(context, listen: false);

    return Column(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => onClickHandler(),
            child: Container(
              padding: const EdgeInsets.all(Constants.kDefaultPadding),
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: product.id,
                child: Image.network(product.imageURL),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Constants.kDefaultPadding / 4,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: Constants.kDefaultPadding / 3,
              horizontal: Constants.kDefaultPadding / 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(height: 4),
                      Text('\$${product.price}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<Product>(
                      builder: (context, product, _) => GestureDetector(
                        onTap: () => product.toggleFavoriteStatus(),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: const Color(0xFFff7096),
                          size: 22,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => cart.addItem(
                        productId: product.id,
                        title: product.title,
                        price: product.price,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/cart.svg',
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn,
                        ),
                        width: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
