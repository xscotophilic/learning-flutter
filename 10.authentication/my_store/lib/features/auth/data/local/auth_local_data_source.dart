import 'dart:convert';

import 'package:my_store/core/storage/local_storage.dart';
import 'package:my_store/features/auth/data/models/user_model.dart';

abstract final class _Keys {
  static const token = 'session_token';
  static const user = 'session_user';
}

class AuthLocalDataSource {
  const AuthLocalDataSource(this._storage);

  final LocalStorage _storage;

  Future<void> saveSession(String token, UserModel user) async {
    await Future.wait([
      _storage.write(_Keys.token, token),
      _storage.write(_Keys.user, jsonEncode(user.toJson())),
    ]);
  }

  Future<(String, UserModel)?> loadSession() async {
    final token = await _storage.read(_Keys.token);
    final userJson = await _storage.read(_Keys.user);

    if (token == null || userJson == null) return null;

    try {
      final decoded = jsonDecode(userJson) as Map<String, dynamic>;
      final user = UserModel.fromJson(decoded);
      return (token, user);
    } catch (_) {
      await clearSession();
      return null;
    }
  }

  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(_Keys.token),
      _storage.delete(_Keys.user),
    ]);
  }
}
