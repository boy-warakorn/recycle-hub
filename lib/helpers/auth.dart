import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userInfo(
    FirebaseUser user,
  ) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userInfo);
  }

  Future register(
    String email,
    String password,
    String firstname,
    String lastname,
    String address,
    String postalCode,
    String phoneNumber,
    BuildContext context,
  ) async {
    AuthResult authResult;

    try {
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'firstname': firstname,
        'lastname': lastname,
        'address': address,
        'postalCode': postalCode,
        'phoneNumber': phoneNumber,
      });

      FirebaseUser user = authResult.user;

      return _userInfo(user);
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return true;
    } catch (err) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(
            seconds: 2,
          ),
          content: Text(
            err.toString(),
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.white,
                ),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );

      return null;
    }
  }

  getFirstName(userId) async {
    final userData =
        await Firestore.instance.collection("users").document(userId).get();
    return userData;
  }
}
