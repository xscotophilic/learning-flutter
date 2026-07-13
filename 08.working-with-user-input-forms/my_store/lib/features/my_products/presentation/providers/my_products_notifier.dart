import 'package:my_store/features/home/presentation/providers/home_notifier.dart';
import 'package:my_store/features/my_products/domain/entities/my_products.dart';
import 'package:my_store/features/my_products/presentation/providers/my_products_usecase_providers.dart';
import 'package:my_store/features/product/domain/entities/product.dart';
import 'package:my_store/features/product/presentation/providers/product_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_products_notifier.g.dart';

@riverpod
class MyProductsNotifier extends _$MyProductsNotifier {
  @override
  Future<MyProductsSnapshot> build() async {
    final useCase = ref.watch(getMyProductsUseCaseProvider);
    final productIds = await useCase.execute();

    return MyProductsSnapshot(productIds: productIds);
  }

  Future<void> createProduct(Product product) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    state = AsyncData(
      snapshot.copyWith(mutationStatus: MyProductsMutationStatus.mutating),
    );
    try {
      final useCase = ref.read(createProductUseCaseProvider);
      final createdProduct = await useCase.execute(product);

      state = AsyncData(
        snapshot.copyWith(
          mutationStatus: MyProductsMutationStatus.success,
          productIds: [...snapshot.productIds, createdProduct.id],
        ),
      );

      ref.invalidate(homeProvider);
    } catch (e, st) {
      state = AsyncData(
        snapshot.copyWith(mutationStatus: MyProductsMutationStatus.idle),
      );
      state = AsyncError(e, st);
    }
  }

  Future<void> updateProduct(Product product) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    state = AsyncData(
      snapshot.copyWith(mutationStatus: MyProductsMutationStatus.mutating),
    );
    try {
      final useCase = ref.read(updateProductUseCaseProvider);
      await useCase.execute(product);

      state = AsyncData(
        snapshot.copyWith(mutationStatus: MyProductsMutationStatus.success),
      );

      ref.invalidate(productProvider(product.id));
    } catch (e, st) {
      state = AsyncData(
        snapshot.copyWith(mutationStatus: MyProductsMutationStatus.idle),
      );
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteProduct({required String id}) async {
    final snapshot = state.value ?? await future;
    if (snapshot.isMutating) return;

    final deleteProduct = ref.read(deleteProductUseCaseProvider);

    state = AsyncData(
      snapshot.copyWith(mutationStatus: MyProductsMutationStatus.mutating),
    );
    try {
      await deleteProduct.execute(id: id);

      state = AsyncData(
        snapshot.copyWith(
          mutationStatus: MyProductsMutationStatus.success,
          productIds: snapshot.productIds.where((e) => e != id).toList(),
        ),
      );

      final homeSnapshot = ref.read(homeProvider).value;
      if (homeSnapshot?.featuredProductIds.contains(id) ?? false) {
        ref.invalidate(homeProvider);
      }
    } catch (e, st) {
      state = AsyncData(
        snapshot.copyWith(mutationStatus: MyProductsMutationStatus.idle),
      );
      state = AsyncError(e, st);
    }
  }
}
