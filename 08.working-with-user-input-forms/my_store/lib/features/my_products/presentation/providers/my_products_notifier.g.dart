// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_products_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyProductsNotifier)
final myProductsProvider = MyProductsNotifierProvider._();

final class MyProductsNotifierProvider
    extends $AsyncNotifierProvider<MyProductsNotifier, MyProductsSnapshot> {
  MyProductsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProductsNotifierHash();

  @$internal
  @override
  MyProductsNotifier create() => MyProductsNotifier();
}

String _$myProductsNotifierHash() =>
    r'57eeb708089870f4eba55084c600cc5c2212fa6f';

abstract class _$MyProductsNotifier extends $AsyncNotifier<MyProductsSnapshot> {
  FutureOr<MyProductsSnapshot> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<MyProductsSnapshot>, MyProductsSnapshot>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MyProductsSnapshot>, MyProductsSnapshot>,
              AsyncValue<MyProductsSnapshot>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
