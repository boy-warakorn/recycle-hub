import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Icon icon;

  DrawerItem({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
