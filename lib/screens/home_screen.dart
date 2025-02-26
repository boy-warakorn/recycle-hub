import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../widgets/drawer/drawer.dart';
import '../widgets/logo/logoText.dart';
import '../widgets/button/buttonHomeBox.dart';
import '../widgets/shopItems/main_shop_items.dart';

import '../models/user.dart';

import 'auth/auth_screen.dart';
import 'shop/own_shop_screen.dart';
import './waste_info_screen.dart';
import './chat/main_chat_screen.dart';
import 'shop/main_shop_screen.dart';
import './profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _show = true;

  List<DocumentSnapshot> shownItems;

  void onChanged() {
    if (mounted) {
      setState(() {
        _show = !_show;
      });
    }
  }

  fetchTwoItems() async {
    final items = await Firestore.instance.collection('items').getDocuments();

    List<DocumentSnapshot> temp = [items.documents[0]];
    temp.add(items.documents[1]);
    if (mounted) {
      setState(() {
        shownItems = temp;
      });
    }
  }

  @override
  void initState() {
    fetchTwoItems();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final deviceWidth = MediaQuery.of(context).size.width;

    if (user != null) {
      if (shownItems == null) {
        return Scaffold(
          body: Center(
            child: SpinKitCircle(color: Theme.of(context).primaryColor),
          ),
        );
      } else {
        return Scaffold(
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
              child: ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Manage',
                        style: Theme.of(context).textTheme.headline2.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            secondChild: Text(
                              'show',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
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
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            secondChild: IconButton(
                              onPressed: onChanged,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).primaryColor,
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
                  AnimatedCrossFade(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    firstChild: Row(
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
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(MainChatScreen.routeName);
                          },
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
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName);
                          },
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
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed(OwnShopScreen.routeName);
                          },
                        ),
                      ],
                    ),
                    secondChild: Material(
                      type: MaterialType.transparency,
                    ),
                    crossFadeState: _show
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
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
                        text: 'Main shop',
                        icon: Icon(
                          Icons.shopping_cart,
                          size: 70,
                          color: Theme.of(context).accentColor,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(MainShopScreen.routeName);
                        },
                      ),
                      ButtonHomeBox(
                        height: 120,
                        width: deviceWidth / 2.4,
                        text: 'Recycle waste?',
                        // icon: Icon(
                        //   Icons.help,
                        //   size: 70,
                        //   color: Theme.of(context).accentColor,
                        // ),
                        isAwesome: true,
                        faIcon: FaIcon(
                          FontAwesomeIcons.recycle,
                          size: 70,
                          color: Theme.of(context).accentColor,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(WasteInfoScreen.routeName);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Suggested',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(MainShopScreen.routeName),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Show All',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MainShopItem(
                        assetPath: shownItems[0]['itemImagePath'],
                        height: 225,
                        price: shownItems[0]['itemPrice'],
                        isNetwork: true,
                        id: shownItems[0]["itemId"],
                        per: shownItems[0]["itemUnit"],
                        width: deviceWidth / 2.4,
                        title: shownItems[0]["itemName"],
                      ),
                      MainShopItem(
                        assetPath: shownItems[1]['itemImagePath'],
                        height: 225,
                        price: shownItems[1]['itemPrice'],
                        isNetwork: true,
                        id: shownItems[1]["itemId"],
                        per: shownItems[1]["itemUnit"],
                        width: deviceWidth / 2.4,
                        title: shownItems[1]["itemName"],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    } else {
      return AuthScreen();
    }
  }
}
