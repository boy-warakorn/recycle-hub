import 'package:flutter/material.dart';

import '../../widgets/shopItems/main_shop_items.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/shopItems/list_Item.dart';

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
    final deviceHeight = MediaQuery.of(context).size.height;

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
        'price': '30',
        "per": 'Kg',
        'assetPath': 'assets/images/cardboard_mockup.png',
        'shopName': 'testNumberTwo',
        'detail':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem '
      },
      {
        'id': '3',
        'title': 'Newspaper',
        'price': '100',
        "per": 'Kg',
        'assetPath': 'assets/images/newspaper_mockup.png',
        'shopName': 'testNumberThree',
        'detail':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sociis mollis cursus pharetra dictumst mus. Mauris consectetur placerat dignissim morbi lorem '
      },
    ];

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
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: DUMMY_ITEM.length,
                        itemBuilder: (ctx, index) => MainShopItem(
                          assetPath: DUMMY_ITEM[index]['assetPath'],
                          per: DUMMY_ITEM[index]['per'],
                          price: DUMMY_ITEM[index]['price'],
                          title: DUMMY_ITEM[index]['title'],
                          id: DUMMY_ITEM[index]['id'],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              child: ListView.builder(
                itemCount: DUMMY_ITEM.length,
                itemBuilder: (ctx, index) => ListItem(
                  assetPath: DUMMY_ITEM[index]['assetPath'],
                  per: DUMMY_ITEM[index]['per'],
                  price: DUMMY_ITEM[index]['price'],
                  title: DUMMY_ITEM[index]['title'],
                  id: DUMMY_ITEM[index]['id'],
                  shopName: DUMMY_ITEM[index]['shopName'],
                ),
              ),
            ),
    );
  }
}
