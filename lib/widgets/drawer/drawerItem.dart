import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Function onTap;
  final bool isAwesome;
  final FaIcon faIcon;

  DrawerItem({
    this.title,
    this.icon,
    this.onTap,
    this.isAwesome = false,
    this.faIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          isAwesome ? faIcon : icon,
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ],
      ),
    );
  }
}
