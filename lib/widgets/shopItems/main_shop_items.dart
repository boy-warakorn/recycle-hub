import 'package:flutter/material.dart';

class MainShopItem extends StatelessWidget {
  final String title;
  final String price;
  final String per;
  final String assetPath;

  MainShopItem({
    this.title,
    this.price,
    this.per,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        margin: EdgeInsets.all(
          0,
        ),
        color: Color(0xFFEFFCEF),
        elevation: 4,
        child: Column(
          children: <Widget>[
            Container(
              height: 172.7,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    30,
                  ),
                  topRight: Radius.circular(
                    30,
                  ),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    assetPath,
                  ),
                ),
              ),
            ),
            Container(
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
                    child: Container(
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
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 12,
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
                            Container(
                              margin: EdgeInsets.only(
                                top: 2,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: Theme.of(context).primaryColor,
                              ),
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
    );
  }
}
