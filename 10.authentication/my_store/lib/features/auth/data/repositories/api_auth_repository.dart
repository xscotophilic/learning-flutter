import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/features/auth/data/models/auth_response_model.dart';
import 'package:my_store/features/auth/domain/entities/user.dart';
import 'package:my_store/features/auth/domain/repositories/auth_repository.dart';

final class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository(this._apiClient, this._googleSignIn);

  final ApiClient _apiClient;
  final GoogleSignIn _googleSignIn;

  @override
  Future<void> initialize() async {
    await _googleSignIn.initialize(
      serverClientId:
          '133016414218-hujhmf162df52jsqp0qmf4aqqf4baupg.apps.googleusercontent.com',
    );
  }

  @override
  Future<(String, User)> signInWithGoogle() async {
    final account = await _googleSignIn.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw Exception('Failed to retrieve Google ID token.');
    }

    final json = await _apiClient.post(
      '/auth/google',
      body: {'id_token': idToken},
    );
    final response = AuthResponseModel.fromJson(json as Map<String, dynamic>);

    return (response.token, response.user.toDomain());
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
