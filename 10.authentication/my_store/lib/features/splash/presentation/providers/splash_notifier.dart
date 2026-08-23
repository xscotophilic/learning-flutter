import 'package:my_store/features/auth/presentation/providers/auth_notifier.dart';
import 'package:my_store/features/splash/domain/entities/splash_state.dart';
import 'package:my_store/features/splash/presentation/providers/splash_usecase_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_notifier.g.dart';

@riverpod
class SplashNotifier extends _$SplashNotifier {
  @override
  Future<SplashState> build() async {
    // We wait for both auth and splash data before continuing. Auth is
    // `read` (not `watch`) since we just need token/user populated once
    // before proceeding, and we don't need to react to auth changes
    // afterwards.
    final results = await (
      ref.read(authProvider.future),
      ref.watch(checkAppStatusUseCaseProvider).execute(),
    ).wait;

    final (_, state) = results;
    return state;
  }
}
