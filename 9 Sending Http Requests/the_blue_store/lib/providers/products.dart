import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './dev.dart';
import './product.dart';
import '../data.dart';

class Products with ChangeNotifier {
  List<Product> _items = PRODUCTS;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return items.where((item) => item.isFavorite).toList();
  }

  Product findByID(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void addProduct(Product product) {
    var url = Uri.parse(
      DevConfig.APIEndPoint + '/products.json',
    );
    http
        .post(
      url,
      body: jsonEncode(
        {
          'id': DateTime.now().toString(),
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageURL': product.imageURL,
          'isFavorite': product.isFavorite,
          'color': product.color,
        },
      ),
    )
        .then(
      (response) {
        final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageURL: product.imageURL,
          color: product.color,
        );
        _items.insert(0, newProduct);
        notifyListeners();
      },
    );
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex > -1) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
