import 'package:flutter/material.dart';

import '../../widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/chat';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.call,
            ),
            onPressed: () {},
          )
        ],
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            Text(
              'Chat',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            TextField(
              style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                fillColor: Theme.of(context).primaryColor,
                filled: true,
                hintText: 'Send Message',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
                errorStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
