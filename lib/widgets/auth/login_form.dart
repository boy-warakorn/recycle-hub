import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../button/button.dart';
import '../../screens/auth/register_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  var _userEmail = '';
  var _userPassword = '';
  final _formKey = GlobalKey<FormState>();
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (!isValid) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(
            seconds: 2,
          ),
          content: Text(
            'Please correct a form',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return;
    } else {
      _formKey.currentState.save();
      login(
        _userEmail.trim(),
        _userPassword.trim(),
      );
    }
    // FocusScope.of(context).unfocus();
  }

  void login(
    String email,
    String password,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        _isLoading = false;
      });
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Email",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('email'),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    10,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                ),
                validator: (value) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value) || value.trim() == '') {
                    return 'This is not a valid email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _userEmail = value;
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Password",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                key: ValueKey('password'),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(
                    10,
                  ),
                  errorStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  isDense: true,
                  hintText: 'Enter your Password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                validator: (value) {
                  if (value.length < 6 || value.trim() == '') {
                    return "Length of password should be at least 7";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  _userPassword = value;
                },
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Don\'t have account ?',
                style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                    ),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                elevation: 10,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RegisterScreen.routeName,
                  );
                },
                color: Color(0xFFEFFCEF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Text(
                  "Sign up",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          !_isLoading
              ? Center(
                  child: Button(
                    text: 'Sign In',
                    buttonColor: Color(0xFFEFFCEF),
                    textColor: Theme.of(context).primaryColor,
                    onClick: () {
                      _trySubmit();
                      //Sign in function here
                    },
                  ),
                )
              : Center(
                  child: Button(
                    child: Text('asd'),
                    buttonColor: Color(0xFFEFFCEF),
                    textColor: Theme.of(context).primaryColor,
                    onClick: null,
                  ),
                )
        ],
      ),
    );
  }
}
