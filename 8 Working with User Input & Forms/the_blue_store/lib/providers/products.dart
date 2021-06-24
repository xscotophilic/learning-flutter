import 'package:flutter/material.dart';

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
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageURL: product.imageURL,
      color: product.color,
      id: DateTime.now().toString(),
    );
    _items.insert(0, newProduct);
    notifyListeners();
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
