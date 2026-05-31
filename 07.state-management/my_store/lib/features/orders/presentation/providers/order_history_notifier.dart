import 'package:my_store/features/orders/data/repositories/orders_repository_provider.dart';
import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_history_notifier.g.dart';

@riverpod
class OrderHistoryNotifier extends _$OrderHistoryNotifier {
  @override
  Future<List<Order>> build() async {
    final ordersRepository = ref.watch(ordersRepositoryProvider);
    return ordersRepository.getOrders();
  }
}
