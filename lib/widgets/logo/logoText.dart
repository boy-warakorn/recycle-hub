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
            style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.white,
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
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ],
      ),
    );
  }
}
