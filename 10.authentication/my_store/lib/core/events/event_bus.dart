import 'package:my_store/core/events/app_event.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_bus.g.dart';

@Riverpod(keepAlive: true)
class EventBus extends _$EventBus {
  @override
  AppEvent? build() => null;

  void emit(AppEvent event) {
    state = event;
  }

  void consume() {
    state = null;
  }
}
