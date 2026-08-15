import 'package:my_store/features/auth/data/local/auth_local_data_source.dart';
import 'package:my_store/features/auth/data/local/auth_remote_data_source.dart';
import 'package:my_store/features/auth/data/local/google_auth_data_source.dart';
import 'package:my_store/features/auth/domain/entities/auth.dart';
import 'package:my_store/features/auth/domain/repositories/auth_repository.dart';

final class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository(
    this._googleAuthDataSource,
    this._remoteDataSource,
    this._localDataSource,
  );

  final GoogleAuthDataSource _googleAuthDataSource;
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<void> initialize() async {
    await _googleAuthDataSource.initialize(
      '133016414218-hujhmf162df52jsqp0qmf4aqqf4baupg.apps.googleusercontent.com',
    );
  }

  @override
  Future<(String, User)?> restoreSession() async {
    final session = await _localDataSource.loadSession();
    if (session == null) return null;

    final (token, userModel) = session;
    return (token, userModel.toDomain());
  }

  @override
  Future<(String, User)> signInWithGoogle() async {
    final idToken = await _googleAuthDataSource.authenticate();
    if (idToken == null) {
      throw Exception('Failed to retrieve Google ID token.');
    }

    final response = await _remoteDataSource.signInWithGoogle(idToken);

    await _localDataSource.saveSession(response.token, response.user);
    return (response.token, response.user.toDomain());
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _googleAuthDataSource.signOut(),
      _localDataSource.clearSession(),
    ]);
  }
}
