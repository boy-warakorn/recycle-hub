import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final bool isMe;
  final Key key;

  MessageCard({this.isMe, this.key});

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
                horizontal: 16,
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
                    'It\'s me',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'asdaddaadasdasdasdsdaasd',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.end,
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
