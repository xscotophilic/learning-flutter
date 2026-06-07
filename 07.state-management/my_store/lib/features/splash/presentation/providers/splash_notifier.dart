import 'package:my_store/features/splash/domain/entities/splash_state.dart';
import 'package:my_store/features/splash/domain/usecases/check_app_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  Future<SplashState> build() async {
    final checkAppStatus = ref.watch(checkAppStatusUseCaseProvider);
    return checkAppStatus.execute();
  }
}
