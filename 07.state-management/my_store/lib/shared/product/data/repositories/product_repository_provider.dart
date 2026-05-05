import 'package:my_store/shared/product/data/repositories/mock_product_repository.dart';
import 'package:my_store/shared/product/domain/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) {
  return MockProductRepository();
}
