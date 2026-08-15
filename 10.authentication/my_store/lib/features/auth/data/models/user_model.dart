import 'package:my_store/features/auth/domain/entities/auth.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
    );
  }

  final String id;
  final String email;
  final String name;
  final String picture;

  User toDomain() {
    return User(id: id, email: email, name: name, picture: picture);
  }
}
