import 'package:my_store/core/dependency_injection/network_providers.dart';
import 'package:my_store/features/auth/domain/entities/auth_state.dart';
import 'package:my_store/features/auth/presentation/providers/auth_usecase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<AuthSnapshot> build() async {
    final initializeAuthRepository = ref.read(
      initializeAuthRepositoryUseCaseProvider,
    );
    await initializeAuthRepository.execute();

    return const AuthSnapshot(user: null);
  }

  Future<void> signInWithGoogle() async {
    final snapshot = state.value ?? const AuthSnapshot(user: null);
    if (snapshot.isMutating) return;

    state = AsyncData(snapshot.copyWith(isMutating: true));
    try {
      final signInWithGoogle = ref.read(signInWithGoogleUseCaseProvider);
      final (token, user) = await signInWithGoogle.execute();

      ref.read(authTokenProvider.notifier).setToken(token);
      state = AsyncData(AuthSnapshot(user: user));
    } catch (e, st) {
      state = AsyncData(snapshot.copyWith(isMutating: false));
      state = AsyncError(e, st);
    }
  }

  Future<void> signOut() async {
    final snapshot = state.value;
    if (snapshot == null || snapshot.isMutating) return;

    state = AsyncData(snapshot.copyWith(isMutating: true));
    try {
      final signOut = ref.read(signOutUseCaseProvider);
      await signOut.execute();
    } finally {
      state = const AsyncData(AuthSnapshot(user: null));
      ref.read(authTokenProvider.notifier).setToken(null);
    }
  }
}
