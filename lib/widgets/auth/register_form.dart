import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../button/button.dart';
import '../../helpers/auth.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AuthService _auth = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _userPassword = '';
  var _userFirstName = '';
  var _userLastName = '';
  var _userAddress = '';
  var _userPostalCode = '';
  var _userPhoneNumber = '';

  void _trySubmit() async {
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
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState.save();
      await _auth.register(
        _userEmail.trim(),
        _userPassword.trim(),
        _userFirstName.trim(),
        _userLastName.trim(),
        _userAddress.trim(),
        _userPostalCode.trim(),
        _userPhoneNumber.trim(),
        context,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: SingleChildScrollView(
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
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Firstname",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    key: ValueKey('firstName'),
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
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
                      hintText: 'Enter your First name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value.trim() == '') {
                        return 'Value should not be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userFirstName = value;
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
                    "Lastname",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    key: ValueKey('lastName'),
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
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
                      hintText: 'Enter your Last name',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value.trim() == '') {
                        return 'Value should not be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userLastName = value;
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
                    "Address",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    key: ValueKey('address'),
                    maxLines: 3,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(
                        10,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      hintText: 'Enter your address',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value.trim() == '') {
                        return 'Value should not be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userAddress = value;
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
                    "Postal Code",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    key: ValueKey('postalCode'),
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(
                        10,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      hintText: 'Enter your Postal code',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value.trim() == '' ||
                          value.length < 5 && value.length > 5) {
                        return 'This is not a valid postal code';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userPostalCode = value;
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
                    "Phone Number",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    key: ValueKey('phoneNumber'),
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.phone,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white,
                      ),
                      contentPadding: EdgeInsets.all(
                        10,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      hintText: 'Enter your phone number',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (value) {
                      if (value.length < 10 ||
                          value.length > 10 ||
                          value.trim() == '') {
                        return 'This is not a valid phone-number';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _userPhoneNumber = value;
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  !_isLoading
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Button(
                            text: 'Sign up',
                            buttonColor: Color(0xFFEFFCEF),
                            textColor: Theme.of(context).primaryColor,
                            onClick: () {
                              _trySubmit();
                            },
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Button(
                            child: Text('asd'),
                            buttonColor: Color(0xFFEFFCEF),
                            textColor: Theme.of(context).primaryColor,
                            onClick: null,
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
