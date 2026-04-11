import 'package:flutter/material.dart';
import 'package:my_store/providers/orders.dart';
import 'package:my_store/screens/orders/components/order_item.dart';
import 'package:provider/provider.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return ListView.builder(
      itemCount: ordersData.orders.length,
      itemBuilder: (context, index) =>
          OrderItemCard(order: ordersData.orders[index]),
    );
  }
}
