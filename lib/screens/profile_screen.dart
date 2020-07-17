import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/user.dart';
import 'auth/auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isInit = false;
  var firstname;
  var lastname;
  var address;
  var postalCode;
  var phoneNumber;

  fetchUserData() async {
    final user = Provider.of<User>(context);
    var info =
        await Firestore.instance.collection('users').document(user.uid).get();
    if (mounted) {
      setState(() {
        firstname = info['firstname'];
        lastname = info['lastname'];
        address = info['address'];
        postalCode = info['postalCode'];
        phoneNumber = info['phoneNumber'];
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      fetchUserData();
    }
    if (mounted) {
      setState(() {
        _isInit = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              Text(
                'Profile',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                20,
              ),
              topRight: Radius.circular(
                20,
              ),
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(
              20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 132,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: firstname != null
                      ? Text(
                          '$firstname $lastname',
                          style: Theme.of(context).textTheme.headline2,
                        )
                      : SpinKitCircle(
                          color: Theme.of(context).primaryColor,
                        ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Your address',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.black,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.all(
                    20,
                  ),
                  child: address != null
                      ? Text(
                          '$address $postalCode',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                        )
                      : SpinKitCircle(
                          color: Colors.white,
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Your phone number',
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        color: Colors.black,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding: EdgeInsets.all(
                    20,
                  ),
                  child: phoneNumber != null
                      ? Text(
                          '$phoneNumber',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                        )
                      : SpinKitCircle(
                          color: Colors.white,
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return AuthScreen();
    }
  }
}
