import 'package:flutter/material.dart';

import '../choose_screen.dart';
import '../../widgets/button/button.dart';
import '../../widgets/labelTextField.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color(0xFF94D3AC),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Create Account',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Color(0xFF655C56),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: ListView(
              children: <Widget>[
                LabelTextField(labelText: 'Email'),
                SizedBox(
                  height: 15,
                ),
                LabelTextField(labelText: 'Password'),
                SizedBox(
                  height: 15,
                ),
                LabelTextField(labelText: 'Postal Code'),
                SizedBox(
                  height: 15,
                ),
                LabelTextField(labelText: 'Phone Number'),
                SizedBox(
                  height: 15,
                ),
                LabelTextField(labelText: 'Username'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Button(
                        text: 'Sign up',
                        buttonColor: Color(0xFFEFFCEF),
                        textColor: Theme.of(context).primaryColor,
                        onClick: () {
                          Navigator.of(context)
                              .pushNamed(ChooseScreen.routeName);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
