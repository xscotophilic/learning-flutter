import 'package:flutter/material.dart';
import 'package:my_store/data.dart';
import 'package:my_store/providers/product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = globalProducts;

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
