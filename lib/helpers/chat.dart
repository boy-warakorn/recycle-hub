import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ChatService {
  Future sendMessage(String userId, String chatRoomId, String message,
      TextEditingController controller) async {
    try {
      controller.clear();
      var chatId;
      var username;
      final refChat = Firestore.instance.collection("chats").document();
      await refChat.get().then(
            (value) => chatId = value.documentID,
          );
      final now = Timestamp.now();
      DateTime onlyTime = now.toDate();
      final time = DateFormat("HH:mm").format(onlyTime);

      final userData = username =
          await Firestore.instance.collection("users").document(userId).get();
      username = userData["firstname"];
      await refChat.setData({
        "userName": username,
        "chatId": chatId,
        "chatRoomId": chatRoomId,
        "createdAt": now,
        "message": message,
        "userId": userId,
      });
      await Firestore.instance
          .collection("chatrooms")
          .document(chatRoomId)
          .updateData(
        {
          "time": time,
          "updatedAt": now,
          "latestMessage": message,
          "userName": username,
        },
      );
    } catch (err) {
      print(err);
    }
  }

  Future createChatRoom(
    String userId,
    String anotherUserId,
    BuildContext context,
  ) async {
    try {
      if (await checkAlreadyChat(userId, anotherUserId)) {
        return;
      }
      var chatRoomId;
      final refChatRoom = Firestore.instance.collection('chatrooms').document();

      await refChatRoom.get().then(
            (value) => chatRoomId = value.documentID,
          );
      await refChatRoom.setData({
        "chatRoomId": chatRoomId,
        "users": [userId, anotherUserId],
        "updatedAt": Timestamp.now(),
      });
    } on PlatformException catch (err) {
      print(err);
    } catch (err) {
      print(err);
    }
  }

  Future<bool> checkAlreadyChat(userId, anotherUserId) async {
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
    });

    if (temp.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
