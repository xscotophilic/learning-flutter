import 'package:my_store/features/product/domain/entities/price.dart';
import 'package:my_store/features/product/domain/entities/product.dart';

class PriceModel {
  const PriceModel({
    required this.amount,
    required this.currency,
    this.discountPercent,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    final discount = json['discount_percent'];
    return PriceModel(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      discountPercent: discount != null ? (discount as num).toDouble() : null,
    );
  }

  factory PriceModel.fromDomain(Price price) {
    return PriceModel(
      amount: price.amount,
      currency: price.currency,
      discountPercent: price.discountPercent,
    );
  }

  final double amount;
  final String currency;
  final double? discountPercent;

  Price toDomain() {
    return Price(
      amount: amount,
      currency: currency,
      discountPercent: discountPercent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
      if ((discountPercent ?? 0) > 0) 'discount_percent': discountPercent,
    };
  }
}

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.creatorId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: PriceModel.fromJson(json['price'] as Map<String, dynamic>),
      imageUrl: json['image_url'] as String,
      creatorId: json['creator_id'] as String,
    );
  }

  factory ProductModel.fromDomain(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: PriceModel.fromDomain(product.price),
      imageUrl: product.imageUrl,
      creatorId: product.creatorId,
    );
  }

  final String id;
  final String name;
  final String description;
  final PriceModel price;
  final String imageUrl;
  final String creatorId;

  Product toDomain() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price.toDomain(),
      imageUrl: imageUrl,
      creatorId: creatorId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      'description': description,
      'price': price.toJson(),
      'image_url': imageUrl,
    };
  }
}

class ProductsPayloadModel {
  const ProductsPayloadModel({required this.products});

  factory ProductsPayloadModel.fromJson(Map<String, dynamic> json) {
    final rawProducts = json['products'];
    if (rawProducts is! List) {
      throw const FormatException('invalid product list');
    }

    return ProductsPayloadModel(
      products: rawProducts
          .map((x) => ProductModel.fromJson(x as Map<String, dynamic>))
          .toList(),
    );
  }

  final List<ProductModel> products;

  List<Product> toDomain() {
    return products.map((p) => p.toDomain()).toList();
  }
}
