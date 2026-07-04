import 'package:my_store/features/my_products/domain/entities/my_products.dart';
import 'package:my_store/features/my_products/presentation/providers/my_products_usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_products_notifier.g.dart';

@riverpod
class MyProductsNotifier extends _$MyProductsNotifier {
  @override
  Future<MyProductsSnapshot> build() async {
    final useCase = ref.watch(getMyProductsUseCaseProvider);
    final productIds = await useCase.execute(userId: '000001');

    return MyProductsSnapshot(isMutating: false, productIds: productIds);
  }

  Future<void> deleteProduct({required String id}) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    final deleteProduct = ref.read(deleteProductUseCaseProvider);

    state = AsyncData(snapshot.copyWith(isMutating: true));
    try {
      await deleteProduct.execute(id: id);
      state = AsyncData(snapshot.copyWith(isMutating: false));
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncData(snapshot.copyWith(isMutating: false));
      state = AsyncError(e, st);
    }
  }
}
