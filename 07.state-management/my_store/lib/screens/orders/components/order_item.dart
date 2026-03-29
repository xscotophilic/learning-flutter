import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_store/const.dart';
import 'package:my_store/providers/orders.dart';

class OrderItemCard extends StatefulWidget {
  const OrderItemCard({super.key, required this.order});

  final OrderItem order;

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
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
              padding: const EdgeInsets.all(Constants.kDefaultPadding),
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
                          const SizedBox(height: 8),
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
