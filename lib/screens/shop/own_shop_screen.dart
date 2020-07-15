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

enum ViewOptions {
  ListView,
  GridView,
  Help,
}

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
                  setState(() {
                    searchText = text;
                  });
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
            setState(() {
              _isSearch = !_isSearch;
              if (!_isSearch) {
                searchText = "";
              }
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
                    } else if (selectedValue == ViewOptions.Help) {
                      _showAlert(context);
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
                  PopupMenuItem(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Helps'),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.help,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    value: ViewOptions.Help,
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
                        height: deviceHeight - appbar.preferredSize.height - 83,
                        child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('items')
                              .where("userId", isEqualTo: user.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            // print(snapshot.data.documents[0]['itemDetail']);
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: SpinKitCircle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            }
                            if (snapshot.hasData &&
                                snapshot.data.documents.length > 0) {
                              final List item = snapshot.data.documents;

                              String search = searchText.toLowerCase();

                              final renderItem = item
                                  .where(
                                    (element) => element['itemName']
                                        .toLowerCase()
                                        .contains(search),
                                  )
                                  .toList();

                              return renderItem.length != 0
                                  ? GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: //0.68
                                            0.8,
                                      ),
                                      itemCount: renderItem.length,
                                      itemBuilder: (ctx, index) => MainShopItem(
                                        assetPath: renderItem[index]
                                            ['itemImagePath'],
                                        per: renderItem[index]['itemUnit'],
                                        price: renderItem[index]['itemPrice'],
                                        title: renderItem[index]['itemName'],
                                        id: renderItem[index]['itemId'],
                                        isNetwork: true,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'No results found!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
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
                    ],
                  ),
                ),
              )
            : Container(
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
                    if (snapshot.hasData &&
                        snapshot.data.documents.length > 0) {
                      final List item = snapshot.data.documents;

                      String search = searchText.toLowerCase();

                      final renderItem = item
                          .where(
                            (element) => element['itemName']
                                .toLowerCase()
                                .contains(search),
                          )
                          .toList();
                      return renderItem.length != 0
                          ? ListView.builder(
                              itemCount: renderItem.length + 1,
                              itemBuilder: (ctx, index) {
                                if (index == renderItem.length) {
                                  return SizedBox(
                                    height: 100,
                                  );
                                } else {
                                  return ListItem(
                                    assetPath: renderItem[index]
                                        ['itemImagePath'],
                                    per: renderItem[index]['itemUnit'],
                                    price: renderItem[index]['itemPrice'],
                                    title: renderItem[index]['itemName'],
                                    id: renderItem[index]['itemId'],
                                    shopName: renderItem[index]['shopName'],
                                    isNetwork: true,
                                    isOwnShop: true,
                                  );
                                }
                              })
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
