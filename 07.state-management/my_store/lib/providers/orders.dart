import 'package:flutter/material.dart';
import 'package:my_store/providers/cart.dart';

class OrderItem {
  const OrderItem({
    required this.id,
    required this.ammount,
    required this.products,
    required this.dateTime,
  });

  final String id;
  final double ammount;
  final List<CartItem> products;
  final DateTime dateTime;
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        ammount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
