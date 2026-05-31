import 'package:my_store/features/orders/data/repositories/mock_orders_repository.dart';
import 'package:my_store/features/orders/domain/repositories/orders_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_repository_provider.g.dart';

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(Ref ref) {
  return const MockOrdersRepository();
}
