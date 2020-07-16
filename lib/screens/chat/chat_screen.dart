import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/chat.dart';

import '../../models/user.dart';
import '../auth/auth_screen.dart';

import '../../widgets/chat/messages.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatService _chat = ChatService();
  var _controller = TextEditingController();

  var _isLoading = false;

  trySendMessage(userId, chatRoomId) async {
    setState(() {
      _isLoading = true;
    });
    await _chat.sendMessage(userId, chatRoomId, _controller.text, _controller);
    _controller.clear();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatroomId = ModalRoute.of(context).settings.arguments;

    final user = Provider.of<User>(context);
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
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
                child: Messages(
                  chatRoomId: chatroomId,
                  currentUserId: user.uid,
                ),
              ),
              TextField(
                controller: _controller,
                style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: !_isLoading
                        ? () {
                            trySendMessage(user.uid, chatroomId);
                          }
                        : null,
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
    } else {
      return AuthScreen();
    }
  }
}
