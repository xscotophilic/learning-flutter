// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductNotifier)
final productProvider = ProductNotifierFamily._();

final class ProductNotifierProvider
    extends $AsyncNotifierProvider<ProductNotifier, Product?> {
  ProductNotifierProvider._({
    required ProductNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productNotifierHash();

  @override
  String toString() {
    return r'productProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductNotifier create() => ProductNotifier();

  @override
  bool operator ==(Object other) {
    return other is ProductNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productNotifierHash() => r'c0f124e6de951ad7ee9fb50bb48970f6f66c6252';

final class ProductNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductNotifier,
          AsyncValue<Product?>,
          Product?,
          FutureOr<Product?>,
          String
        > {
  ProductNotifierFamily._()
    : super(
        retry: null,
        name: r'productProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductNotifierProvider call(String id) =>
      ProductNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'productProvider';
}

abstract class _$ProductNotifier extends $AsyncNotifier<Product?> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<Product?> build(String id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Product?>, Product?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Product?>, Product?>,
              AsyncValue<Product?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
