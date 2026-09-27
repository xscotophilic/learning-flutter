import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/cart/domain/usecases/get_hydrated_cart.dart';
import 'package:my_store/features/cart/domain/usecases/update_cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_usecase_providers.g.dart';

@riverpod
GetHydratedCartUseCase getHydratedCartUseCase(Ref ref) {
  return GetHydratedCartUseCase(
    cartRepository: ref.watch(cartRepositoryProvider),
    productRepository: ref.watch(productRepositoryProvider),
  );
}

@riverpod
UpdateCartItemUseCase updateCartItemUseCase(Ref ref) {
  return UpdateCartItemUseCase(
    cartRepository: ref.watch(cartRepositoryProvider),
    productRepository: ref.watch(productRepositoryProvider),
  );
}
