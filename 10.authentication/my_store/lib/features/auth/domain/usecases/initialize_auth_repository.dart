import 'package:my_store/features/auth/domain/repositories/auth_repository.dart';

class InitializeAuthRepositoryUseCase {
  const InitializeAuthRepositoryUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<void> execute() async {
    return _authRepository.initialize();
  }
}
