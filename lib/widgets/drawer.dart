import 'package:flutter/material.dart';

import 'drawerItem.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEFFCEF),
            Theme.of(context).accentColor,
          ],
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            20,
          ),
          bottomRight: Radius.circular(
            20,
          ),
        ),
      ),
      width: deviceWidth / 1.3,
      child: Column(
        children: <Widget>[
          Container(
            height: deviceHeight / 4,
            width: double.infinity,
            child: Card(
              elevation: 10,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(
                    20,
                  ),
                  bottomLeft: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(
                  top: 60,
                  left: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Recycle Hub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Warakorn Chantranupong',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              left: 30,
            ),
            child: Column(
              children: <Widget>[
                DrawerItem(
                  title: 'Your shop',
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  title: 'Profiles',
                  icon: Icon(
                    Icons.account_circle,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  title: 'Contact us',
                  icon: Icon(
                    Icons.live_help,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  title: 'Chat',
                  icon: Icon(
                    Icons.message,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                DrawerItem(
                  title: 'Home',
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
