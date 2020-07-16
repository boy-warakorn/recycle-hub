import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ChatService {
  Future createChatRoom(
    String userId,
    String anotherUserId,
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
