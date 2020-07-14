import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../widgets/auth/register_form.dart';
import '../choose_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
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
                  style: Theme.of(context).textTheme.headline1,
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
            child: RegisterForm(),
          ));
    } else {
      return ChooseScreen();
    }
  }
}
