import 'package:my_store/features/product/domain/entities/product.dart';

class ProductsPayload {
  const ProductsPayload({required this.products});

  factory ProductsPayload.fromJson(Map<String, dynamic> json) {
    if (json['products'] is! List<Map<String, dynamic>>) {
      throw const FormatException('invalid product list');
    }

    final products = json['products'] as List<Map<String, dynamic>>;
    return ProductsPayload(
      products: products.map((x) => Product.fromJson(x)).toList(),
    );
  }

  final List<Product> products;
}
