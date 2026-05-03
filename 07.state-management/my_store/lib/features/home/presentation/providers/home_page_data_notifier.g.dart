// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_data_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePageDataNotifier)
final homePageDataProvider = HomePageDataNotifierProvider._();

final class HomePageDataNotifierProvider
    extends $AsyncNotifierProvider<HomePageDataNotifier, HomePageData> {
  HomePageDataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homePageDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homePageDataNotifierHash();

  @$internal
  @override
  HomePageDataNotifier create() => HomePageDataNotifier();
}

String _$homePageDataNotifierHash() =>
    r'3831adee6c7bbb66fb5befca7d6c08441cb9f6ac';

abstract class _$HomePageDataNotifier extends $AsyncNotifier<HomePageData> {
  FutureOr<HomePageData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HomePageData>, HomePageData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomePageData>, HomePageData>,
              AsyncValue<HomePageData>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
