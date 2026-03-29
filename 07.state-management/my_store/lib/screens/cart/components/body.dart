import 'package:flutter/material.dart';
import 'package:my_store/const.dart';
import 'package:my_store/providers/cart.dart';
import 'package:my_store/providers/orders.dart';
import 'package:my_store/screens/cart/components/cart_item.dart';
import 'package:provider/provider.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Padding(
      padding: const EdgeInsets.all(Constants.kDefaultPadding),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(Constants.kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  Text(
                    '\$${cart.totalAmmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<Orders>(
                        context,
                        listen: false,
                      ).addOrder(cart.items.values.toList(), cart.totalAmmount);
                      cart.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Constants.kDefaultPadding),
          cart.itemCount > 0
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: const Text('Swipe item to remove it from cart.'),
                )
              : const SizedBox(height: 0),
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
              : const Center(child: Text('Add some items.')),
        ],
      ),
    );
  }
}
