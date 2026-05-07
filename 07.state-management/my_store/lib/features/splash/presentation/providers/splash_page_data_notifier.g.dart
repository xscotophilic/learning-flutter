// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_page_data_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SplashPageDataNotifier)
final splashPageDataProvider = SplashPageDataNotifierProvider._();

final class SplashPageDataNotifierProvider
    extends $AsyncNotifierProvider<SplashPageDataNotifier, void> {
  SplashPageDataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashPageDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashPageDataNotifierHash();

  @$internal
  @override
  SplashPageDataNotifier create() => SplashPageDataNotifier();
}

String _$splashPageDataNotifierHash() =>
    r'963ddfa66d7cefd72e5db15ed2c8c5d80d580088';

abstract class _$SplashPageDataNotifier extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
