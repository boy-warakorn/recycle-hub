import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final String color;
  final Function onClick;
  Button({this.text, this.color, this.onClick});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(text),
      onPressed: onClick,
      
    );
  }
}
