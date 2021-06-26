import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/orders.dart';
import '../../../providers/cart.dart';

class OrderNowButton extends StatefulWidget {
  const OrderNowButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderNowButtonState createState() => _OrderNowButtonState();
}

class _OrderNowButtonState extends State<OrderNowButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (widget.cart.totalAmmount <= 0 || _isLoading)
          ? () {}
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(
                context,
                listen: false,
              ).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      child: _isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                child: CircularProgressIndicator(),
                height: 12.0,
                width: 12.0,
              ),
            )
          : Text(
              'Order Now',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.normal,
              ),
            ),
      style: ElevatedButton.styleFrom(primary: Theme.of(context).accentColor),
    );
  }
}
