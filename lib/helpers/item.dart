import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';

class ItemService {
  Future submitAddForm(
    String itemName,
    String itemPrice,
    String itemUnit,
    String itemDetail,
    File image,
    String uid,
    BuildContext ctx,
  ) async {
    try {
      var itemId;
      final refItem = Firestore.instance
          .collection('items')
          .document(uid)
          .collection('itemUser')
          .document();

      //for getting id of item
      await refItem.get().then(
            (value) => itemId = value.documentID,
          );

      final ref = FirebaseStorage.instance
          .ref()
          .child('item_image')
          .child(itemId + '.jpg');

      await ref.putFile(image).onComplete;

      final url = await ref.getDownloadURL();

      refItem.setData({
        'itemId': itemId,
        'itemName': itemName,
        'itemPrice': itemPrice,
        'itemUnit': itemUnit,
        'itemDetail': itemDetail,
        'itemImagePath': url,
      });

      Navigator.of(ctx).pop();
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      return true;
    } catch (err) {
      print(err);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }
}
