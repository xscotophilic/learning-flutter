import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './order_item.dart';
import '../../../providers/orders.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
      builder: (ctx, dataSnapshot) {
        if (dataSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (dataSnapshot.error != null) {
            return Center(
              child: Text('An error occured!'),
            );
          } else {
            return Consumer<Orders>(
              builder: (ctx, orderData, child) => ListView.builder(
                itemCount: orderData.orders.length,
                itemBuilder: (context, index) => OrderItemCard(
                  order: orderData.orders[index],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
