import 'package:my_store/core/dependency_injection/repository_providers.dart';
import 'package:my_store/features/auth/domain/usecases/initialize_auth_repository.dart';
import 'package:my_store/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:my_store/features/auth/domain/usecases/sign_out.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_usecase_providers.g.dart';

@riverpod
InitializeAuthRepositoryUseCase initializeAuthRepositoryUseCase(Ref ref) {
  return InitializeAuthRepositoryUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}
