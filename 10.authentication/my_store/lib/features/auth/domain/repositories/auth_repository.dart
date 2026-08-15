import 'package:my_store/features/auth/domain/entities/auth.dart';

abstract interface class AuthRepository {
  Future<void> initialize();

  Future<(String, User)> signInWithGoogle();

  Future<void> signOut();
}
