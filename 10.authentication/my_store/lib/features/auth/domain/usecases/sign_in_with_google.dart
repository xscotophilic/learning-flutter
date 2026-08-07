import 'package:my_store/features/auth/domain/entities/user.dart';
import 'package:my_store/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  const SignInWithGoogleUseCase(this._authRepository);

  final AuthRepository _authRepository;

  Future<(String, User)> execute() async {
    return _authRepository.signInWithGoogle();
  }
}
