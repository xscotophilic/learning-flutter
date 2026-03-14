import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    required this.color,
    required this.image,
  });

  final String id;
  final String title;
  final Color color;
  final String image;
}
