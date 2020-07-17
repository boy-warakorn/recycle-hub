import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/shopItems/main_shop_items.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/shopItems/list_Item.dart';
import '../../widgets/button/buttonWithIcon.dart';
import '../../widgets/button/button.dart';

import '../../models/user.dart';
import '../auth/auth_screen.dart';

import '../../screens/shop/add_item_screen.dart';

class OwnShopScreen extends StatefulWidget {
  static const routeName = '/ownShop';

  @override
  _OwnShopScreenState createState() => _OwnShopScreenState();
}

class _OwnShopScreenState extends State<OwnShopScreen> {
  var searchText = '';
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool _showGridView = false;
  bool _isSearch = false;

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(Icons.help),
            SizedBox(
              width: 3,
            ),
            Text("Helps"),
          ],
        ),
        backgroundColor: Colors.white,
        content: Container(
          height: 205,
          child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/swipe_left.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Swipe left to delete items'),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Button(
                    buttonColor: Theme.of(context).primaryColor,
                    text: "Okay",
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    textColor: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final deviceHeight = MediaQuery.of(context).size.height;

    AppBar appbar = AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: !_isSearch
          ? Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _drawerKey.currentState.openDrawer();
                  },
                ),
                Text(
                  'Your Shop',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            )
          : Container(
              child: TextField(
                onChanged: (text) {
                  if (mounted) {
                    setState(() {
                      searchText = text;
                    });
                  }
                },
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search here',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.grey,
                      ),
                ),
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.white,
                    ),
                cursorColor: Colors.white,
              ),
            ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            if (mounted) {
              setState(() {
                _isSearch = !_isSearch;
                if (!_isSearch) {
                  searchText = "";
                }
              });
            }
          },
          icon: !_isSearch
              ? Icon(
                  Icons.search,
                  color: Colors.white,
                )
              : Icon(
                  Icons.close,
                  color: Colors.white,
                ),
        ),
        !_isSearch
            ? IconButton(
                icon: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                onPressed: () {
                  _showAlert(context);
                },
              )
            : Material(type: MaterialType.transparency),
        SizedBox(
          width: 5,
        ),
      ],
    );
    if (user != null) {
      return Scaffold(
        key: _drawerKey,
        drawer: MainDrawer(),
        appBar: appbar,
        body: Container(
          margin: EdgeInsets.only(
            top: 5,
          ),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('items')
                .where("userId", isEqualTo: user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitCircle(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }
              if (snapshot.hasData && snapshot.data.documents.length > 0) {
                final List item = snapshot.data.documents;

                String search = searchText.toLowerCase();

                final renderItem = item
                    .where(
                      (element) =>
                          element['itemName'].toLowerCase().contains(search),
                    )
                    .toList();
                return renderItem.length != 0
                    ? Scrollbar(
                        child: ListView.builder(
                            itemCount: renderItem.length + 1,
                            itemBuilder: (ctx, index) {
                              if (index == renderItem.length) {
                                return SizedBox(
                                  height: 100,
                                );
                              } else {
                                return ListItem(
                                  assetPath: renderItem[index]['itemImagePath'],
                                  per: renderItem[index]['itemUnit'],
                                  price: renderItem[index]['itemPrice'],
                                  title: renderItem[index]['itemName'],
                                  id: renderItem[index]['itemId'],
                                  shopName: renderItem[index]['shopName'],
                                  isNetwork: true,
                                  isOwnShop: true,
                                );
                              }
                            }),
                      )
                    : Center(
                        child: Text(
                          'No results found!',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      );
              }
              return Center(
                child: Text(
                  'Please insert item first.',
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            },
          ),
        ),
        floatingActionButton: ButtonWithIcon(
          text: 'Add item',
          icon: Icon(
            Icons.add_box,
            size: 26,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(
              AddItemScreen.routeName,
              arguments: [false, "asd"],
            );
          },
        ),
      );
    } else {
      return AuthScreen();
    }
  }
}
