import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_blue_store/providers/auth.dart';

import '../../../providers/cart.dart';
import '../../../providers/auth.dart';
import '../../../providers/product.dart';
import '../../../const.dart';

class ItemCard extends StatelessWidget {
  final Function onClickHandler;

  const ItemCard({
    Key? key,
    required this.onClickHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => onClickHandler(),
            child: Container(
              padding: EdgeInsets.all(Constants.kDefaultPaddin),
              decoration: BoxDecoration(
                color: convertToColor(product.color),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.network(product.imageURL),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Constants.kDefaultPaddin / 4,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: Constants.kDefaultPaddin / 3,
              horizontal: Constants.kDefaultPaddin / 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width < 400 ? 80 : 200,
                      child: Text(
                        product.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "\$${product.price}",
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<Product>(
                      builder: (context, product, _) => GestureDetector(
                        onTap: () => product.toggleFavoriteStatus(
                            authData.token, authData.userID),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFFff7096),
                          size: 22,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        cart.addItem(
                          ProductId: product.id,
                          title: product.title,
                          price: product.price,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.title} Added to the cart.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () {
                                cart.removeSingleItem(product.id);
                              },
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        "assets/icons/cart.svg",
                        color: Theme.of(context).accentColor,
                        width: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Color convertToColor(String color) {
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      return Color(int.parse("0xFF" + color));
    } else if (color.length == 8) {
      return Color(int.parse("0x" + color));
    }
    return Color(0xFFFFFFFF);
  }
}
