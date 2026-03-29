import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/orders.dart';
import './order_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return ListView.builder(
      itemCount: ordersData.orders.length,
      itemBuilder: (context, index) => OrderItemCard(
        order: ordersData.orders[index],
      ),
    );
  }
}
