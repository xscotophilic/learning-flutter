import 'package:my_store/shared/domain/entities/product.dart';

class HomePageData {
  const HomePageData({
    required this.heroProduct,
    required this.featuredProducts,
  });

  final Product heroProduct;
  final List<Product> featuredProducts;
}
