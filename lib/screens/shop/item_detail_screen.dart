import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/button/buttonWithIcon.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = '/itemDetail';

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  var title;
  var price;
  var per;
  var assetPath;
  var detail;
  var shopName;
  var itemId;
  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      fetchItemDetail();
    } else {
      isInit = true;
    }
  }

  fetchItemDetail() async {
    String itemIdSearch = ModalRoute.of(context).settings.arguments;
    final info = await Firestore.instance
        .collection("items")
        .document(itemIdSearch)
        .get();

    print(info);
    setState(() {
      title = info['itemName'];
      price = info['itemPrice'];
      per = info['itemUnit'];
      assetPath = info['itemImagePath'];
      detail = info['itemDetail'];
      itemId = info['itemId'];
      shopName = info['shopName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (shopName != null) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: itemId,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(assetPath),
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
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
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
                          height: 15,
                        ),
                        Text(
                          'Price: $price Baht/$per',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Shop name: $shopName',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontWeight: FontWeight.bold,
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
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          detail,
                          style: Theme.of(context).textTheme.bodyText1,
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
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
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
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          detail,
                          style: Theme.of(context).textTheme.bodyText1,
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
          onPressed: () {},
        ),
      );
    } else {
      return Scaffold(
        body: Center(
            child: SpinKitChasingDots(
          color: Theme.of(context).primaryColor,
        )),
      );
    }
  }
}
