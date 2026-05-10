// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductDetailsNotifier)
final productDetailsProvider = ProductDetailsNotifierFamily._();

final class ProductDetailsNotifierProvider
    extends $AsyncNotifierProvider<ProductDetailsNotifier, Product?> {
  ProductDetailsNotifierProvider._({
    required ProductDetailsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'productDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailsNotifierHash();

  @override
  String toString() {
    return r'productDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductDetailsNotifier create() => ProductDetailsNotifier();

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailsNotifierHash() =>
    r'a8fff41a1c159a18aca9cc22213d721c86dbbb37';

final class ProductDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductDetailsNotifier,
          AsyncValue<Product?>,
          Product?,
          FutureOr<Product?>,
          String
        > {
  ProductDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'productDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailsNotifierProvider call(String id) =>
      ProductDetailsNotifierProvider._(argument: id, from: this);

  @override
  String toString() => r'productDetailsProvider';
}

abstract class _$ProductDetailsNotifier extends $AsyncNotifier<Product?> {
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
