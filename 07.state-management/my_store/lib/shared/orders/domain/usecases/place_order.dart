import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/shared/orders/domain/repositories/orders_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_order.g.dart';

class PlaceOrderUseCase {
  PlaceOrderUseCase({
    required this.ordersRepository,
  });

  final OrdersRepository ordersRepository;

  Future<void> execute({
    required String cartId,
    required String paymentId,
    required String paymentMethodId,
  }) async {
    return ordersRepository.placeOrder(
      cartId: cartId,
      paymentId: paymentId,
      paymentMethodId: paymentMethodId,
    );
  }
}

@riverpod
PlaceOrderUseCase placeOrderUseCase(Ref ref) {
  return PlaceOrderUseCase(
    ordersRepository: ref.watch(ordersRepositoryProvider),
  );
}
