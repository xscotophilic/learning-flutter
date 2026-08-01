import 'package:my_store/features/product/domain/entities/price.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.creatorId,
  });

  final String id;
  final String name;
  final String description;
  final Price price;
  final String imageUrl;
  final String creatorId;
}
