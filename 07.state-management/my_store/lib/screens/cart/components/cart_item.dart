import 'package:flutter/material.dart';
import 'package:my_store/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title, style: Theme.of(context).textTheme.bodySmall),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x '),
          ),
        ),
      ),
    );
  }
}
