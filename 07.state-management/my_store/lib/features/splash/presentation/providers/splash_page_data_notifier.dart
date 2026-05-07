import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_page_data_notifier.g.dart';

@riverpod
class SplashPageDataNotifier extends _$SplashPageDataNotifier {
  @override
  FutureOr<void> build() async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }
}
