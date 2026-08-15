import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthDataSource {
  const GoogleAuthDataSource(this._googleSignIn);

  final GoogleSignIn _googleSignIn;

  Future<void> initialize(String serverClientId) async {
    await _googleSignIn.initialize(serverClientId: serverClientId);
  }

  Future<String?> authenticate() async {
    final account = await _googleSignIn.authenticate();
    return account.authentication.idToken;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
