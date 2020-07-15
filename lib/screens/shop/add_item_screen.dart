import 'package:flutter/material.dart';

import '../../widgets/shopItems/item_form.dart';

class AddItemScreen extends StatelessWidget {
  static const routeName = '/add-item';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              'Add item',
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(top: 30, left: 25, right: 25),
          child: ListView(
            children: <Widget>[
              ItemForm(),
            ],
          ),
        ),
      ),
    );
  }
}
