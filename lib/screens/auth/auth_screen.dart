import 'package:flutter/material.dart';

import './register_screen.dart';
import '../choose_screen.dart';
import '../../widgets/labelTextField.dart';
import '../../widgets/button/button.dart';
import '../../widgets/logo/logo.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEFFCEF),
              Theme.of(context).accentColor,
            ],
          ),
        ),
        child: Container(
          child: ListView(
            children: <Widget>[
              Logo(),
              Center(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 370,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        LabelTextField(
                          labelText: 'Username',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        LabelTextField(
                          labelText: 'Password',
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Don\'t have account ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
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
                        Center(
                          child: Button(
                            text: 'Sign In',
                            buttonColor: Color(0xFFEFFCEF),
                            textColor: Theme.of(context).primaryColor,
                            onClick: () {
                              //Sign in function here
                              Navigator.of(context)
                                  .pushNamed(ChooseScreen.routeName);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
