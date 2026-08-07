import 'package:my_store/features/auth/domain/entities/user.dart';

class AuthSnapshot {
  const AuthSnapshot({
    required this.user,
    this.isMutating = false,
  });

  final User? user;
  final bool isMutating;

  AuthSnapshot copyWith({
    User? user,
    bool? isMutating,
  }) {
    return AuthSnapshot(
      user: user ?? this.user,
      isMutating: isMutating ?? this.isMutating,
    );
  }
}
