// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EventBus)
final eventBusProvider = EventBusProvider._();

final class EventBusProvider extends $NotifierProvider<EventBus, AppEvent?> {
  EventBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventBusHash();

  @$internal
  @override
  EventBus create() => EventBus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppEvent? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppEvent?>(value),
    );
  }
}

String _$eventBusHash() => r'f80fe9ba62f5e0d353e10fb1b5f179f6749aa372';

abstract class _$EventBus extends $Notifier<AppEvent?> {
  AppEvent? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppEvent?, AppEvent?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppEvent?, AppEvent?>,
              AppEvent?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
