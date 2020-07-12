import 'package:flutter/material.dart';

import '../widgets/button/buttonWithIcon.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/itemDetail';
  @override
  Widget build(BuildContext context) {
    const DUMMY_ITEM = const [
      {
        'id': '1',
        'title': 'Bottle',
        'price': '50',
        "per": 'Kg',
        'assetPath': 'assets/images/bottle_mockup.jpg',
        'shopName': 'testNumberOne',
        'detail':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem ',
      },
      {
        'id': '2',
        'title': 'Card board',
        'price': '50',
        "per": 'Kg',
        'assetPath': 'assets/images/cardboard_mockup.png',
        'shopName': 'testNumberTwo',
        'detail':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem '
      },
    ];
    final itemId = ModalRoute.of(context).settings.arguments;
    final itemSelected =
        DUMMY_ITEM.firstWhere((element) => element['id'] == itemId);
    final title = itemSelected['title'];
    final price = itemSelected['price'];
    final per = itemSelected['per'];
    final assetPath = itemSelected['assetPath'];
    final detail = itemSelected['detail'];
    final shopName = itemSelected['shopName'];

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: itemId,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(assetPath),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 30,
                    right: 30,
                    bottom: 80,
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            '$price Baht/$per',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Shop name: $shopName',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Detail',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        detail,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 200,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        detail,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonWithIcon(
        text: 'Contact',
        icon: Icon(
          Icons.chat,
          size: 26,
          color: Colors.white,
        ),
      ),
    );
  }
}
