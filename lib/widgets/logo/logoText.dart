import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  final Color color;

  LogoText({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      child: Row(
        children: <Widget>[
          Text(
            'Recycle',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).accentColor,
            ),
            child: Text(
              'Hub',
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
