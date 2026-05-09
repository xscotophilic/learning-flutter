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
    extends $AsyncNotifierProvider<SplashPageDataNotifier, SplashState> {
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
    r'afe753b36b7a9338fde87355574a3e233640840c';

abstract class _$SplashPageDataNotifier extends $AsyncNotifier<SplashState> {
  FutureOr<SplashState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SplashState>, SplashState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SplashState>, SplashState>,
              AsyncValue<SplashState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
