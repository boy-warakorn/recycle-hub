import 'package:flutter/material.dart';

import '../../widgets/button/button.dart';

class CreateShopScreen extends StatelessWidget {
  static const routeName = '/createShop';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 40,
              ),
              height: 300,
              width: 500,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/createShop.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              padding: EdgeInsets.all(
                15,
              ),
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Text(
                    'Shop name',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
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
                      hintText: 'Enter your shop name',
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
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: Button(
                buttonColor: Theme.of(context).primaryColor,
                text: 'Create',
                textColor: Colors.white,
                onClick: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
