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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sociis mollis cursus qfend mauris libero massa id.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Sociis mollis cursus qfend mauris libero massa id.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Button(
                  text: "Home",
                  textColor: Theme.of(context).primaryColor,
                  buttonColor: Color(0xffEFFCEF),
                  onClick: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.routeName);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 15,
                  ),
                  child: Button(
                    text: "Create shop",
                    textColor: Color(0xffEFFCEF),
                    buttonColor: Theme.of(context).primaryColor,
                    onClick: () {},
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
