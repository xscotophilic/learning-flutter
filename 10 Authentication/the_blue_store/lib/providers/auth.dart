import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import '../../providers/dev.dart';

class Auth with ChangeNotifier {
  String _token = '';
  var userData;
  var _expiryDate;
  var _userID;

  bool get isAuth {
    if (token.isEmpty) {
      return false;
    }
    return true;
  }

  String get userID {
    if (!_userID.isEmpty) {
      return _userID;
    }
    return '';
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        !_token.isEmpty) {
      return _token;
    }
    return '';
  }

  Future<void> _authenticate(
      String email, String password, String URLSegment) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:${URLSegment}?key=${DevConfig.FirebaseAuthApiKey}',
    );
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final decodeRresponse = json.decode(response.body);
      if (decodeRresponse['error'] != null) {
        throw HttpException(decodeRresponse['error']['message']);
      }
      _token = decodeRresponse['idToken'];
      _userID = decodeRresponse['localId'];
      _expiryDate = DateTime.now().add(Duration(
        seconds: int.parse(decodeRresponse['expiresIn']),
      ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    await this._authenticate(email, password, 'signUp');
    await this.verifyUserEmail(_token);
  }

  Future<void> signIn(String email, String password) async {
    await this._authenticate(email, password, 'signInWithPassword');
    await this.getUserData();
    if (!userData['users'][0]['emailVerified']) {
      userData = '';
      _token = '';
      throw HttpException('Please Verify Your Email!');
    }
  }

  Future<void> verifyUserEmail(String _token) async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=' +
          DevConfig.FirebaseAuthApiKey,
    );
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {"requestType": "VERIFY_EMAIL", "idToken": _token},
        ),
      );
      final decodeRresponse = json.decode(response.body);
      if (decodeRresponse['error'] != null) {
        throw HttpException(decodeRresponse['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> getUserData() async {
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=' +
          DevConfig.FirebaseAuthApiKey,
    );
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {"idToken": _token},
        ),
      );
      userData = jsonDecode(response.body);
      if (userData['error'] != null) {
        throw HttpException(userData['error']['message']);
      }
      return userData;
    } catch (error) {
      throw error;
    }
  }
}
