import 'package:my_store/core/network/api_client.dart';
import 'package:my_store/features/auth/data/models/auth_response_model.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  Future<AuthResponseModel> signInWithGoogle(String idToken) async {
    final json = await _apiClient.post(
      '/auth/google',
      body: {'id_token': idToken},
    );
    return AuthResponseModel.fromJson(json as Map<String, dynamic>);
  }
}
