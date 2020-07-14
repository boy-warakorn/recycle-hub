import 'package:flutter/material.dart';
import './messages_card.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MessageCard(
          isMe: true,
          key: ValueKey('1'),
        ),
        MessageCard(
          isMe: false,
          key: ValueKey('2'),
        ),
      ],
    );
  }
}
