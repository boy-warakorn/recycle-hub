import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'auth/auth_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Container();
    } else {
      return AuthScreen();
    }
  }
}
