class User {
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
  });

  final String id;
  final String email;
  final String name;
  final String picture;
}

class AuthSnapshot {
  const AuthSnapshot({required this.user, this.isMutating = false});

  final User? user;
  final bool isMutating;

  AuthSnapshot copyWith({User? user, bool? isMutating}) {
    return AuthSnapshot(
      user: user ?? this.user,
      isMutating: isMutating ?? this.isMutating,
    );
  }
}
