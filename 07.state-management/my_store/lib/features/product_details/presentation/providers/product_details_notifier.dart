import 'package:my_store/shared/product/data/repositories/product_repository_provider.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_details_notifier.g.dart';

@riverpod
class ProductDetailsNotifier extends _$ProductDetailsNotifier {
  @override
  Future<Product?> build(String id) async {
    final repository = ref.read(productRepositoryProvider);
    final products = await repository.getProductsByIds(productIds: [id]);
    return products.firstOrNull;
  }
}
