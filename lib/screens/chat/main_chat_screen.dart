import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../widgets/chat/chat_card.dart';
import '../../models/user.dart';
import '../auth/auth_screen.dart';

class MainChatScreen extends StatefulWidget {
  static const routeName = '/mainChat';

  @override
  _MainChatScreenState createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  var text;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Main Chat',
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 30,
            //     vertical: 25,
            //   ),
            //   child: TextField(
            //     onChanged: (val) {
            //       setState(() {
            //         text = val;
            //       });
            //     },
            //     style: Theme.of(context).textTheme.headline3.copyWith(
            //           color: Colors.white,
            //           fontWeight: FontWeight.normal,
            //         ),
            //     cursorColor: Colors.white,
            //     decoration: InputDecoration(
            //       fillColor: Theme.of(context).primaryColor,
            //       filled: true,
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Colors.white,
            //       ),
            //       hintText: 'Search by shop name',
            //       hintStyle: TextStyle(
            //         color: Colors.grey,
            //         fontSize: 14,
            //         fontFamily: 'Montserrat',
            //         fontWeight: FontWeight.w500,
            //       ),
            //       errorStyle: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.bold,
            //         backgroundColor: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 25,
                  ),
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("chatrooms")
                        .orderBy("updatedAt", descending: true)
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
                        List allChatroomDocs = snapshot.data.documents;
                        final userId = user.uid;

                        List chatrooms = allChatroomDocs.where((element) {
                          if (element["users"][0] == userId ||
                              element["users"][1] == userId) {
                            return true;
                          } else {
                            return false;
                          }
                        }).toList();

                        return Scrollbar(
                          child: ListView.builder(
                            itemCount: chatrooms.length,
                            itemBuilder: (context, index) => ChatCard(
                              latestMessage:
                                  chatrooms[index]["latestMessage"] == null
                                      ? "Start chat >>"
                                      : chatrooms[index]["latestMessage"],
                              userName: chatrooms[index]["userName"] == null
                                  ? "Start send message......"
                                  : chatrooms[index]["userName"],
                              when: chatrooms[index]["time"] == null
                                  ? "--:--"
                                  : chatrooms[index]["time"],
                              chatRoomId: chatrooms[index]["chatRoomId"],
                            ),
                          ),
                        );
                      }
                      return Material(
                        type: MaterialType.transparency,
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return AuthScreen();
    }
  }
}
