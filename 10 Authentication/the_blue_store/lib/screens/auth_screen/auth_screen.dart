import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../const.dart';
import '../../providers/auth.dart';
import '../../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/store.png"),
                          fit: BoxFit.contain,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/logo.svg",
                        height: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: deviceSize.width > 600 ? 6 : 3,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  void _showErrorDiag(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(
                'Okay',
              )),
        ],
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).signIn(
          _authData['email'] as String,
          _authData['password'] as String,
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'] as String,
          _authData['password'] as String,
        );
      }
    } on HttpException catch (error) {
      var errorMessasge = error.toString();
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessasge = 'This email is already in use.';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessasge = 'Too many attempts try later.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessasge =
            'There is no user record corresponding to this identifier.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessasge = 'The password is invalid.';
      } else if (error.toString().contains('USER_DISABLED')) {
        errorMessasge = 'The user account has been disabled.';
      }
      _showErrorDiag(errorMessasge);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      const errorMessasge = 'Could not authenticate you, Please try again!';
      _showErrorDiag(errorMessasge);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _authMode == AuthMode.Signup ? 320 : 260,
      constraints:
          BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
      margin: EdgeInsets.symmetric(
        vertical: Constants.kDefaultPaddin,
        horizontal: Constants.kDefaultPaddin * 2,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  var pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                  final result = new RegExp(pattern, caseSensitive: false)
                      .firstMatch(value as String);
                  if (value.isEmpty || result == null) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value as String;
                },
              ),
              TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                },
                onSaved: (value) {
                  _authData['password'] = value as String;
                },
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  enabled: _authMode == AuthMode.Signup,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                        }
                      : null,
                ),
              SizedBox(
                height: 20,
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                InkWell(
                  onTap: () => _submit(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Constants.kDefaultPaddin * 2.8,
                      vertical: Constants.kDefaultPaddin / 2,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: new LinearGradient(
                        colors: [Color(0xFFffc0f0), Color(0xFFffeffb)],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      ),
                    ),
                    child: Text(
                      _authMode == AuthMode.Login ? 'Sign In' : 'Sign Up',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              TextButton(
                child: Text(
                  '${_authMode == AuthMode.Login ? 'Sign Up' : 'Sign In'} Instead',
                  style: Theme.of(context).textTheme.headline6,
                ),
                onPressed: _switchAuthMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
