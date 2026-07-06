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
    r'4383b319c9376672c1b536138857729bb0c8a3f8';

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
