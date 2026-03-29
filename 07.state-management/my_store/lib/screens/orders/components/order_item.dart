import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../const.dart';
import '../../../providers/orders.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  const OrderItemCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: Constants.kDefaultPadding,
        vertical: Constants.kDefaultPadding / 3,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '\$${widget.order.ammount.toStringAsFixed(2)}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                DateFormat('yyyy MMMM dd hh:mm').format(widget.order.dateTime),
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.all(Constants.kDefaultPadding),
              height: min(widget.order.products.length * 20.0 + 40.0, 180.0),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${prod.quantity} x \$${prod.price}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
