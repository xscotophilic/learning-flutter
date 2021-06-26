import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './dev.dart';
import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favItems {
    return items.where((item) => item.isFavorite).toList();
  }

  Product findByID(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
      DevConfig.APIEndPoint + '/products.json',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.insert(
            0,
            Product(
              id: prodId,
              title: prodData['title'],
              description: prodData['description'],
              price: prodData['price'],
              imageURL: prodData['imageURL'],
              color: prodData['color'],
            ),
          );
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
      DevConfig.APIEndPoint + '/products.json',
    );

    try {
      final response = await http.post(
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
      );
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
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex > -1) {
      final url = Uri.parse(
        DevConfig.APIEndPoint + '/products/$id.json',
      );
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageURL': newProduct.imageURL,
            'isFavorite': newProduct.isFavorite,
            'color': newProduct.color,
          }),
        );
      } catch (err) {}
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
      DevConfig.APIEndPoint + '/products/$id.json',
    );
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    final response = await http.delete(url);
    existingProduct.dispose();
    _items.removeAt(existingProductIndex);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    notifyListeners();
  }
}
