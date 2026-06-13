import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/shared/orders/domain/entities/order.dart';
import 'package:my_store/shared/orders/domain/repositories/orders_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_orders.g.dart';

class GetOrdersUseCase {
  GetOrdersUseCase({
    required this.ordersRepository,
  });

  final OrdersRepository ordersRepository;

  Future<List<Order>> execute() async {
    return ordersRepository.getOrders();
  }
}

@riverpod
GetOrdersUseCase getOrdersUseCase(Ref ref) {
  return GetOrdersUseCase(
    ordersRepository: ref.watch(ordersRepositoryProvider),
  );
}
