import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';
import './dev.dart';

class OrderItem {
  final String id;
  final double ammount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.ammount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  var _authToken;

  List<OrderItem> get orders {
    return [..._orders];
  }

  void update(String token, List<OrderItem> previousOrders) {
    _authToken = token;
    _orders = previousOrders;
  }

  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
      '${DevConfig.APIEndPoint}/orders.json?auth=${_authToken}',
    );
    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        return;
      }
      final List<OrderItem> loadedOrders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach(
        (orderId, orderData) {
          loadedOrders.add(
            OrderItem(
              id: orderId,
              ammount: orderData['ammount'],
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                    ),
                  )
                  .toList(),
              dateTime: DateTime.parse(orderData['dateTime']),
            ),
          );
        },
      );
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
      '${DevConfig.APIEndPoint}/orders.json?auth=${_authToken}',
    );
    final response = await http.post(
      url,
      body: json.encode({
        'ammount': total,
        'products': cartProducts
            .map(
              (cartProduct) => {
                'id': cartProduct.id,
                'title': cartProduct.title,
                'quantity': cartProduct.quantity,
                'price': cartProduct.price,
              },
            )
            .toList(),
        'dateTime': timeStamp.toIso8601String(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        ammount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
