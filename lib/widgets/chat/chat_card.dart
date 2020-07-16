import 'package:flutter/material.dart';
import '../../screens/chat/chat_screen.dart';

class ChatCard extends StatelessWidget {
  final chatRoomId;
  final userName;
  final latestMessage;
  final when;

  ChatCard({this.chatRoomId, this.userName, this.latestMessage, this.when});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: chatRoomId,
              );
            },
            child: Ink(
              height: 80,
              width: double.infinity,
              child: Ink(
                padding: EdgeInsets.all(
                  15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          '$when AM',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      latestMessage.length > 30
                          ? "${latestMessage.substring(0, 31)}.."
                          : latestMessage,
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Color(0xFF464646),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
