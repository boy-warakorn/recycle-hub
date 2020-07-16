import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/shop/add_item_screen.dart';
import '../../screens/shop/item_detail_screen.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String id;
  final String shopName;
  final String assetPath;
  final String per;
  final String price;
  final bool isOwnShop;
  final bool isNetwork;

  ListItem({
    this.title,
    this.id,
    this.assetPath,
    this.shopName,
    this.per,
    this.price,
    this.isOwnShop = false,
    this.isNetwork = false,
  });

  deleteItem(String itemId) async {
    await Firestore.instance.collection('items').document(itemId).delete();
  }

  @override
  Widget build(BuildContext context) {
    if (isOwnShop) {
      return Dismissible(
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.delete,
            size: 36,
            color: Colors.white,
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm'),
                content: Text('Are you sure to delete this item?'),
                actions: <Widget>[
                  FlatButton(
                    child: FlatButton(
                      child: Text(
                        'DELETE',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                  FlatButton(
                    child: FlatButton(
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                ],
              );
            },
          );
        },
        direction: DismissDirection.endToStart,
        key: ValueKey(id),
        onDismissed: (direction) => deleteItem(id),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 5,
            left: 5,
            right: 5,
          ),
          child: InkWell(
            onTap: !isOwnShop
                ? () {
                    Navigator.of(context)
                        .pushNamed(ItemDetailScreen.routeName, arguments: id);
                  }
                : null,
            child: Ink(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.grey[300],
                  ),
                  right: BorderSide(
                    color: Colors.grey[300],
                  ),
                  top: BorderSide(
                    color: Colors.grey[300],
                  ),
                  bottom: BorderSide(
                    color: Colors.grey[300],
                  ),
                ),
              ),
              height: 150,
              child: Row(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: 140,
                    child: Hero(
                      tag: id,
                      child: Image(
                        fit: BoxFit.cover,
                        image: isNetwork
                            ? NetworkImage(assetPath)
                            : AssetImage(
                                assetPath,
                              ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 13,
                      right: 13,
                    ),
                    child: Column(
                      mainAxisAlignment: isOwnShop
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              !(shopName.length > 11)
                                  ? 'Shop: $shopName'
                                  : 'Shop: ${shopName.substring(0, 11)}...',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                        isOwnShop
                            ? Container(
                                margin: EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () =>
                                          Navigator.of(context).pushNamed(
                                        AddItemScreen.routeName,
                                        arguments: [true, id],
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  'Edit',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.settings,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Text(
                                        '$price B/$per',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      '$price Baht/$per',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(
          bottom: 5,
          left: 5,
          right: 5,
        ),
        child: InkWell(
          onTap: !isOwnShop
              ? () {
                  Navigator.of(context)
                      .pushNamed(ItemDetailScreen.routeName, arguments: id);
                }
              : null,
          child: Ink(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey[300],
                ),
                right: BorderSide(
                  color: Colors.grey[300],
                ),
                top: BorderSide(
                  color: Colors.grey[300],
                ),
                bottom: BorderSide(
                  color: Colors.grey[300],
                ),
              ),
            ),
            height: 150,
            child: Row(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: 140,
                  child: Hero(
                    tag: id,
                    child: Image(
                      fit: BoxFit.cover,
                      image: isNetwork
                          ? NetworkImage(assetPath)
                          : AssetImage(
                              assetPath,
                            ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 13,
                    right: 13,
                  ),
                  child: Column(
                    mainAxisAlignment: isOwnShop
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            !(shopName.length > 11)
                                ? 'Shop: $shopName'
                                : 'Shop: ${shopName.substring(0, 11)}...',
                            style:
                                Theme.of(context).textTheme.headline3.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ],
                      ),
                      isOwnShop
                          ? Container(
                              margin: EdgeInsets.only(
                                bottom: 15,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 13,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {},
                                              child: Text(
                                                'Edit',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.settings,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      '$price B/$per',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 13,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Text(
                                    '$price Baht/$per',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
