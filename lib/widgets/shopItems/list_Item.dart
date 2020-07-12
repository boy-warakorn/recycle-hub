import 'package:flutter/material.dart';

import '../../screens/item_detail_screen.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String id;
  final String shopName;
  final String assetPath;
  final String per;
  final String price;

  ListItem({
    this.title,
    this.id,
    this.assetPath,
    this.shopName,
    this.per,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ItemDetailScreen.routeName, arguments: id);
        },
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
                margin: EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      !(shopName.length > 11)
                          ? 'Shop name: $shopName'
                          : 'Shop name: ${shopName.substring(0, 11)}...',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
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
