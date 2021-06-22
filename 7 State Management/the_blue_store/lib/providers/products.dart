import 'package:flutter/material.dart';

import './product.dart';
import '../data.dart';

class Products with ChangeNotifier {
  List<Product> _items = PRODUCTS;

  // var _ShowFavsOnly = false;

  List<Product> get items {
    // if (_ShowFavsOnly)
    //   return items.where((item) => item.isFavorite).toList();
    // else
    return [..._items];
  }

  List<Product> get favItems {
    return items.where((item) => item.isFavorite).toList();
  }

  Product findByID(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
