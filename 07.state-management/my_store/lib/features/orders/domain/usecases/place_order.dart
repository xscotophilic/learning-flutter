import 'package:my_store/features/orders/domain/repositories/orders_repository.dart';

class PlaceOrderUseCase {
  const PlaceOrderUseCase({required this.ordersRepository});

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
