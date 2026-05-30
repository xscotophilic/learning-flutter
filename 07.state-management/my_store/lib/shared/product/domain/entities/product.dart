import 'package:my_store/shared/product/domain/entities/price.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: Price.fromJson(json['price'] as Map<String, dynamic>),
      imageUrl: (json['image_url']) as String,
    );
  }

  final String id;
  final String name;
  final String description;
  final Price price;
  final String imageUrl;
}
