import 'package:flutter/material.dart';

import 'screens/auth/auth_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/choose_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF655C56),
        appBarTheme: AppBarTheme(
          color: Color(0xFF655C56),
          elevation: 0,
        ),
        accentColor: Color(0xFF94D3AC),
        fontFamily: 'Montserrat',
      ),
      home: AuthScreen(),
      routes: {
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        ChooseScreen.routeName: (ctx) => ChooseScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
