import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final bool isMe;
  final Key key;
  final String message;
  final String userName;

  MessageCard({this.isMe, this.key, this.message, this.userName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    12,
                  ),
                  topRight: Radius.circular(
                    12,
                  ),
                  bottomLeft: isMe
                      ? Radius.circular(
                          12,
                        )
                      : Radius.circular(
                          0,
                        ),
                  bottomRight: isMe
                      ? Radius.circular(
                          0,
                        )
                      : Radius.circular(
                          12,
                        ),
                ),
                color:
                    !isMe ? Theme.of(context).accentColor : Color(0xFFCCEDD2),
              ),
              width: 170,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
