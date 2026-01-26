import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../providers/dev.dart';

class Product with ChangeNotifier {
  // final String userId;
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageURL;
  final String color;
  bool isFavorite;

  Product({
    // required this.userId,
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageURL,
    required this.color,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userID) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
      '${DevConfig.APIEndPoint}/userFavorites/${userID}/${id}.json?auth=${token}',
    );
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
