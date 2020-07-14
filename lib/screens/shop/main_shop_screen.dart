import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/shopItems/main_shop_items.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/shopItems/list_Item.dart';

import '../../models/user.dart';
import '../auth/auth_screen.dart';

enum ViewOptions {
  ListView,
  GridView,
}

class MainShopScreen extends StatefulWidget {
  static const routeName = '/mainShop';

  @override
  _MainShopScreenState createState() => _MainShopScreenState();
}

class _MainShopScreenState extends State<MainShopScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  bool _showGridView = false;
  bool _isSearch = false;

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
                  icon: Icon(Icons.keyboard_arrow_left),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Shop',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            )
          : Container(
              child: TextField(
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
            setState(() {
              _isSearch = !_isSearch;
            });
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
            ? PopupMenuButton(
                onSelected: (ViewOptions selectedValue) {
                  setState(() {
                    if (selectedValue == ViewOptions.GridView) {
                      _showGridView = true;
                    } else if (selectedValue == ViewOptions.ListView) {
                      _showGridView = false;
                    }
                  });
                },
                icon: Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Grid View',
                        ),
                        Icon(
                          Icons.grid_on,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    value: ViewOptions.GridView,
                  ),
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('List View'),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.list,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    value: ViewOptions.ListView,
                  ),
                ],
              )
            : Material(
                type: MaterialType.transparency,
              ),
      ],
    );
    if (user != null) {
      return Scaffold(
        key: _drawerKey,
        drawer: MainDrawer(),
        appBar: appbar,
        body: _showGridView
            ? Container(
                margin: EdgeInsets.only(
                  left: 20,
                  top: 20,
                  right: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: deviceHeight - appbar.preferredSize.height - 50,
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection('items')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: SpinKitCircle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                );
                              } else if (snapshot.hasData &&
                                  snapshot.data.documents.length > 0) {
                                final item = snapshot.data.documents;
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: //0.68
                                        0.8,
                                  ),
                                  itemCount: item.length,
                                  itemBuilder: (ctx, index) => MainShopItem(
                                    assetPath: item[index]['itemImagePath'],
                                    per: item[index]['itemUnit'],
                                    price: item[index]['itemPrice'],
                                    title: item[index]['itemName'],
                                    id: item[index]['itemId'],
                                    isNetwork: true,
                                  ),
                                );
                              }
                              return Center(
                                child: Text(
                                  'No items right now!',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                child: StreamBuilder(
                    stream: Firestore.instance.collection('items').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitCircle(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data.documents.length > 0) {
                        if (snapshot.hasData &&
                            snapshot.data.documents.length > 0) {
                          final itemDocs = snapshot.data.documents;
                          return ListView.builder(
                            itemCount: itemDocs.length,
                            itemBuilder: (ctx, index) => ListItem(
                              assetPath: itemDocs[index]['itemImagePath'],
                              per: itemDocs[index]['itemUnit'],
                              price: itemDocs[index]['itemPrice'],
                              title: itemDocs[index]['itemName'],
                              id: itemDocs[index]['itemId'],
                              shopName: itemDocs[index]['shopName'],
                              isNetwork: true,
                            ),
                          );
                        }
                      }
                      return Center(
                        child: Text(
                          'No items right now!',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      );
                    }),
              ),
      );
    } else {
      return AuthScreen();
    }
  }
}
