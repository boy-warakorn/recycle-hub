import 'package:flutter/material.dart';

import '../../screens/item_detail_screen.dart';

class MainShopItem extends StatelessWidget {
  final String title;
  final String price;
  final String per;
  final String assetPath;
  final String id;
  final double width;
  final double height;

  MainShopItem({
    this.title,
    this.price,
    this.per,
    this.assetPath,
    this.id,
    this.height = double.infinity,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: InkWell(
        radius: 50,
        onTap: () {
          Navigator.of(context)
              .pushNamed(ItemDetailScreen.routeName, arguments: id);
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          height: height,
          width: width,
          child: Column(
            children: <Widget>[
              Ink(
                height: 172.7,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      30,
                    ),
                    topRight: Radius.circular(
                      30,
                    ),
                  ),
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
              ),
              Ink(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 5,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'SourceSansPro',
                            ),
                          ),
                          Text(
                            '$price Bath/$per',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontFamily: 'SourceSansPro'),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Ink(
                        height: 30,
                        width: deviceWidth / 4.5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                              30,
                            ),
                            topLeft: Radius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: Ink(
                          padding: EdgeInsets.only(
                            left: 15,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'More detail',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).primaryColor,
                                  fontFamily: 'SourceSansPro',
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
