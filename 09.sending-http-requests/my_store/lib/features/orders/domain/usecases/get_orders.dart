import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/features/orders/domain/repositories/orders_repository.dart';

class GetOrdersUseCase {
  const GetOrdersUseCase({required this.ordersRepository});

  final OrdersRepository ordersRepository;

  Future<List<Order>> execute() async {
    return ordersRepository.getOrders();
  }
}
