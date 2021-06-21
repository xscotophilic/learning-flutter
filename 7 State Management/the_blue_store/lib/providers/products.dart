import 'package:flutter/material.dart';

import './product.dart';
import '../data.dart';

class Products with ChangeNotifier {
  List<Product> _items = PRODUCTS;

  List<Product> get items {
    return [..._items];
  }

  Product findByID(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
