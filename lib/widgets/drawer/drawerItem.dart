import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function onTap;

  DrawerItem({
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
      ),
    );
  }
}
