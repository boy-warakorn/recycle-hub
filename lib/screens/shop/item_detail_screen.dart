import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../chat/chat_screen.dart';
import '../../helpers/chat.dart';
import '../../models/user.dart';

import '../../widgets/button/buttonWithIcon.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = '/itemDetail';

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  var _isLoading = false;
  ChatService chat = ChatService();
  var title;
  var price;
  var per;
  var assetPath;
  var detail;
  var shopName;
  var itemId;
  var userId;
  var userAdd;
  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit == false) {
      fetchItemDetail();
    } else {
      if (mounted) {
        setState(() {
          isInit = true;
        });
      }
    }
  }

  createChatHandler(userId, anotherUserId, context) async {
    setState(() {
      _isLoading = true;
    });
    await chat.createChatRoom(userId, anotherUserId, context);

    final info =
        await Firestore.instance.collection("chatrooms").getDocuments();
    final temp = info.documents.where((element) {
      if (element["users"][0] == userId &&
              element["users"][1] == anotherUserId ||
          element["users"][0] == anotherUserId &&
              element["users"][1] == userId) {
        return true;
      } else {
        return false;
      }
    }).toList();
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context)
        .pushNamed(ChatScreen.routeName, arguments: temp[0]["chatRoomId"]);
  }

  fetchItemDetail() async {
    String itemIdSearch = ModalRoute.of(context).settings.arguments;
    final info = await Firestore.instance
        .collection("items")
        .document(itemIdSearch)
        .get();
    userId = info['userId'];
    final userAddress =
        await Firestore.instance.collection('users').document(userId).get();
    if (mounted) {
      setState(() {
        userAdd = userAddress['address'];
        title = info['itemName'];
        price = info['itemPrice'];
        per = info['itemUnit'];
        assetPath = info['itemImagePath'];
        detail = info['itemDetail'];
        itemId = info['itemId'];
        shopName = info['shopName'];
        userId = info['userId'];
      });
    }
  }

  checkAlreadyChat(currentUserId) async {}

  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<User>(context).uid;
    if (shopName != null && !_isLoading) {
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
                        Container(
                          padding: EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            title.substring(0, 1).toUpperCase() +
                                title.substring(1, title.length),
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.moneyBill,
                              color: Colors.black,
                            ),
                            Text(
                              ' : $price Baht/$per',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.userTie,
                              color: Colors.black,
                            ),
                            Text(
                              ' : $shopName',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
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
                        Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.infoCircle,
                              color: Colors.black,
                            ),
                            Text(
                              ' Detail',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          detail,
                          style: Theme.of(context).textTheme.headline3,
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
                        Row(
                          children: <Widget>[
                            FaIcon(
                              FontAwesomeIcons.solidAddressCard,
                              color: Colors.black,
                            ),
                            Text(
                              ' Address',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          userAdd,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: !(userId == currentUserId)
            ? ButtonWithIcon(
                text: 'Contact',
                icon: Icon(
                  Icons.chat,
                  size: 26,
                  color: Colors.white,
                ),
                onPressed: () {
                  createChatHandler(currentUserId, userId, context);
                },
              )
            : null,
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
