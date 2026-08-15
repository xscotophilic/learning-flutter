import 'package:my_store/features/auth/domain/entities/auth.dart';
import 'package:my_store/features/auth/domain/repositories/auth_repository.dart';

class RestoreSessionUseCase {
  const RestoreSessionUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<(String, User)?> execute() => _authRepository.restoreSession();
}
