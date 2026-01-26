import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_blue_store/providers/orders.dart';

import './cart_item.dart';
import '../../../const.dart';
import '../../../providers/cart.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Padding(
      padding: EdgeInsets.all(Constants.kDefaultPaddin),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(Constants.kDefaultPaddin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Spacer(),
                  Text(
                    '\$${cart.totalAmmount.toStringAsFixed(2)}',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(
                        context,
                        listen: false,
                      ).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmmount,
                      );
                      cart.clear();
                    },
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).accentColor),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Constants.kDefaultPaddin,
          ),
          cart.itemCount > 0
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text('Swipe item to remove it from cart.'),
                )
              : SizedBox(
                  height: 0,
                ),
          cart.itemCount > 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) => CartItemCard(
                      id: cart.items.values.toList()[index].id,
                      productId: cart.items.keys.toList()[index],
                      price: cart.items.values.toList()[index].price,
                      quantity: cart.items.values.toList()[index].quantity,
                      title: cart.items.values.toList()[index].title,
                    ),
                  ),
                )
              : Center(
                  child: Text('Add some items.'),
                ),
        ],
      ),
    );
  }
}
