import 'package:my_store/features/orders/domain/entities/order.dart';
import 'package:my_store/features/orders/presentation/providers/orders_usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_history_notifier.g.dart';

@riverpod
class OrderHistoryNotifier extends _$OrderHistoryNotifier {
  @override
  Future<List<Order>> build() async {
    final getOrders = ref.watch(getOrdersUseCaseProvider);
    return getOrders.execute();
  }
}
