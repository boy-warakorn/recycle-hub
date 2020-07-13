import 'package:flutter/material.dart';

import '../../screens/shop/item_detail_screen.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String id;
  final String shopName;
  final String assetPath;
  final String per;
  final String price;
  final bool isOwnShop;

  ListItem({
    this.title,
    this.id,
    this.assetPath,
    this.shopName,
    this.per,
    this.price,
    this.isOwnShop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5,
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
                width: 160,
                child: Hero(
                  tag: id,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
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
                              ? 'Shop name: $shopName'
                              : 'Shop name: ${shopName.substring(0, 11)}...',
                          style: Theme.of(context).textTheme.headline3.copyWith(
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
