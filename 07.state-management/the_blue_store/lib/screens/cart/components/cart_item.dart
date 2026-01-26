import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart.dart';

class CartItemCard extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItemCard({
    Key? key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 15),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(3),
                child: FittedBox(
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x '),
          ),
        ),
      ),
    );
  }
}
