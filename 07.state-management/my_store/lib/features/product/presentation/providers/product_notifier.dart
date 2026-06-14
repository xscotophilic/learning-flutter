import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/domain/usecases/get_product_by_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_notifier.g.dart';

@riverpod
class ProductNotifier extends _$ProductNotifier {
  @override
  Future<Product?> build(String id) async {
    final useCase = ref.watch(getProductByIdUseCaseProvider);
    return useCase.execute(id);
  }
}
