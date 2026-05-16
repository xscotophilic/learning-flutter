import 'package:my_store/shared/product/data/repositories/product_repository_provider.dart';
import 'package:my_store/shared/product/domain/entities/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_notifier.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<Product?> build(String id) async {
    final repository = ref.watch(productRepositoryProvider);
    final products = await repository.getProductsByIds(productIds: [id]);
    return products.firstOrNull;
  }
}
