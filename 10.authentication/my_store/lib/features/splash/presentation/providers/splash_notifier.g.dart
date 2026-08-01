// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SplashNotifier)
final splashProvider = SplashNotifierProvider._();

final class SplashNotifierProvider
    extends $AsyncNotifierProvider<SplashNotifier, SplashState> {
  SplashNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashNotifierHash();

  @$internal
  @override
  SplashNotifier create() => SplashNotifier();
}

String _$splashNotifierHash() => r'48019260aaa75e6d1add30cebcf0695ddf5f414e';

abstract class _$SplashNotifier extends $AsyncNotifier<SplashState> {
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
