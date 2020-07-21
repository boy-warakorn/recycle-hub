import 'package:flutter/material.dart';

import '../widgets/logo/logo.dart';
import '../widgets/button/button.dart';
import '../screens/home_screen.dart';

class ChooseScreen extends StatelessWidget {
  static const routeName = "/choose";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Logo(),
            Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "Welcome to Recycle hub",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20,
              ),
              child: Text(
                "This is a waste dealer application",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200,
                  child: Button(
                    text: "Home",
                    textColor: Theme.of(context).primaryColor,
                    buttonColor: Color(0xffEFFCEF),
                    onClick: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
