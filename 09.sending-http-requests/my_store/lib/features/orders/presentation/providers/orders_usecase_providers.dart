import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/orders/domain/usecases/get_orders.dart';
import 'package:my_store/features/orders/domain/usecases/place_order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_usecase_providers.g.dart';

@riverpod
GetOrdersUseCase getOrdersUseCase(Ref ref) {
  return GetOrdersUseCase(
    ordersRepository: ref.watch(ordersRepositoryProvider),
  );
}

@riverpod
PlaceOrderUseCase placeOrderUseCase(Ref ref) {
  return PlaceOrderUseCase(
    ordersRepository: ref.watch(ordersRepositoryProvider),
  );
}
