import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../widgets/logoText.dart';
import '../widgets/buttonHomeBox.dart';
import '../widgets/shop_items.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _show = true;

  void onChanged() {
    setState(() {
      _show = !_show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        drawer: MainDrawer(),
        appBar: AppBar(
          centerTitle: true,
          titleSpacing: 0,
          elevation: 0,
          title: LogoText(),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Manage',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        AnimatedCrossFade(
                          duration: const Duration(
                            milliseconds: 100,
                          ),
                          firstChild: Text(
                            'hide',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          secondChild: Text(
                            'show',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          crossFadeState: _show
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                        AnimatedCrossFade(
                          duration: const Duration(
                            milliseconds: 100,
                          ),
                          firstChild: IconButton(
                            onPressed: onChanged,
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              size: 30,
                            ),
                          ),
                          secondChild: IconButton(
                            onPressed: onChanged,
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ),
                          crossFadeState: _show
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _show
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonHomeBox(
                            icon: Icon(
                              Icons.message,
                              size: 45,
                              color: Theme.of(context).accentColor,
                            ),
                            text: "Chats",
                            width: deviceWidth / 4,
                            height: 90,
                            onTap: () {},
                          ),
                          ButtonHomeBox(
                            icon: Icon(
                              Icons.account_circle,
                              size: 45,
                              color: Theme.of(context).accentColor,
                            ),
                            text: "Profiles",
                            width: deviceWidth / 4,
                            height: 90,
                            onTap: () {},
                          ),
                          ButtonHomeBox(
                            icon: Icon(
                              Icons.shop,
                              size: 45,
                              color: Theme.of(context).accentColor,
                            ),
                            text: "My Shop",
                            width: deviceWidth / 4,
                            height: 90,
                            onTap: () {},
                          ),
                        ],
                      )
                    : Material(
                        type: MaterialType.transparency,
                      ),
                _show
                    ? SizedBox(
                        height: 15,
                      )
                    : Material(
                        type: MaterialType.transparency,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonHomeBox(
                      height: 120,
                      width: deviceWidth / 2.4,
                      text: 'Go to main shop',
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 70,
                        color: Theme.of(context).accentColor,
                      ),
                      onTap: () {},
                    ),
                    ButtonHomeBox(
                      height: 120,
                      width: deviceWidth / 2.4,
                      text: 'Recycle waste ?',
                      icon: Icon(
                        Icons.help,
                        size: 70,
                        color: Theme.of(context).accentColor,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Suggested for you',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ShopItems(
                      title: 'Bottles',
                      price: '20',
                      per: 'kg',
                      assetPath: 'assets/images/bottle_mockup.jpg',
                    ),
                    ShopItems(
                      title: 'Cardboard',
                      price: '30',
                      per: 'kg',
                      assetPath: "assets/images/cardboard_mockup.png",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
