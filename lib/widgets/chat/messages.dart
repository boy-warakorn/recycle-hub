import 'package:flutter/material.dart';
import './messages_card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatefulWidget {
  final chatRoomId;
  final currentUserId;
  Messages({this.chatRoomId, this.currentUserId});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection("chats")
            .where("chatRoomId", isEqualTo: widget.chatRoomId)
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCircle(
                color: Theme.of(context).primaryColor,
              ),
            );
          }

          if (snapshot.hasData && snapshot.data.documents.length > 0) {
            final chatDocs = snapshot.data.documents;

            return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (context, index) => MessageCard(
                      userName: chatDocs[index]['userName'],
                      message: chatDocs[index]['message'],
                      isMe: chatDocs[index]["userId"] == widget.currentUserId,
                      key: ValueKey(
                        chatDocs[index]["chatId"],
                      ),
                    ));
          }
          return Material(
            type: MaterialType.transparency,
          );
          // return ListView(
          //   children: <Widget>[
          //     MessageCard(
          //       isMe: true,
          //       key: ValueKey('1'),
          //     ),
          //     MessageCard(
          //       isMe: false,
          //       key: ValueKey('2'),
          //     ),
          //   ],
          // );
        });
  }
}
