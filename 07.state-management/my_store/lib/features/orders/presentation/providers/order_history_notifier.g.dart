// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OrderHistoryNotifier)
final orderHistoryProvider = OrderHistoryNotifierProvider._();

final class OrderHistoryNotifierProvider
    extends $AsyncNotifierProvider<OrderHistoryNotifier, List<Order>> {
  OrderHistoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderHistoryNotifierHash();

  @$internal
  @override
  OrderHistoryNotifier create() => OrderHistoryNotifier();
}

String _$orderHistoryNotifierHash() =>
    r'95c875593b51a45eadb32ff437e911644ab37308';

abstract class _$OrderHistoryNotifier extends $AsyncNotifier<List<Order>> {
  FutureOr<List<Order>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Order>>, List<Order>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Order>>, List<Order>>,
              AsyncValue<List<Order>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
