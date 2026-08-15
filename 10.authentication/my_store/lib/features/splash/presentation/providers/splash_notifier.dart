import 'package:my_store/features/auth/presentation/providers/auth_notifier.dart';
import 'package:my_store/features/splash/domain/entities/splash_state.dart';
import 'package:my_store/features/splash/presentation/providers/splash_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  Future<SplashState> build() async {
    // We need token, user, and splash data before we continue,
    // so we wait for auth state and splash data to be ready
    final results = await (
      ref.read(authProvider.future),
      ref.watch(checkAppStatusUseCaseProvider).execute(),
    ).wait;

    final (_, state) = results;
    return state;
  }
}
