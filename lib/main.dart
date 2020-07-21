import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'screens/auth/auth_screen.dart';
import 'screens/auth/register_screen.dart';

import 'screens/choose_screen.dart';
import 'screens/home_screen.dart';
import 'screens/waste_info_screen.dart';
import 'screens/contact_us_screen.dart';
import 'screens/profile_screen.dart';

import 'screens/shop/main_shop_screen.dart';
import 'screens/shop/item_detail_screen.dart';
import 'screens/shop/add_item_screen.dart';
import 'screens/shop/own_shop_screen.dart';

import 'screens/chat/chat_screen.dart';
import 'screens/chat/main_chat_screen.dart';

import 'screens/splash_screen.dart';

import './helpers/auth.dart';
import './helpers/custom_route.dart';
import './models/user.dart';

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
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recycle Hub',
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
          primaryColor: Color(0xFF655C56),
          appBarTheme: AppBarTheme(
            color: Color(0xFF655C56),
            elevation: 0,
          ),
          textTheme: TextTheme(
            //Header 1 text
            headline1: TextStyle(
              fontSize: 24,
              color: Color(0xFF655C56),
              fontWeight: FontWeight.bold,
            ),
            //Header 2 text
            headline2: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            //Header 3 text
            headline3: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF655C56),
            ),
            //body 1 text
            bodyText1: TextStyle(
              fontSize: 15,
              fontFamily: 'SourceSansPro',
              color: Colors.black,
            ),
            //body 2 text
            bodyText2: TextStyle(
              fontSize: 12,
              fontFamily: 'SourceSansPro',
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            headline4: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: Colors.black,
            ),
          ),
          accentColor: Color(0xFF94D3AC),
          fontFamily: 'Montserrat',
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (ctx, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              }
              if (userSnapshot.hasData) {
                return ChooseScreen();
              }
              return AuthScreen();
            }),
        routes: {
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          ChooseScreen.routeName: (ctx) => ChooseScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          MainShopScreen.routeName: (ctx) => MainShopScreen(),
          ItemDetailScreen.routeName: (ctx) => ItemDetailScreen(),
          WasteInfoScreen.routeName: (ctx) => WasteInfoScreen(),
          ContactUsScreen.routeName: (ctx) => ContactUsScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          AddItemScreen.routeName: (ctx) => AddItemScreen(),
          OwnShopScreen.routeName: (ctx) => OwnShopScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          MainChatScreen.routeName: (ctx) => MainChatScreen(),
        },
      ),
    );
  }
}
