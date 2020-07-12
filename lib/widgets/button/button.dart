import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Function onClick;

  Button({
    this.text,
    this.buttonColor,
    this.textColor,
    this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 10,
      onPressed: onClick,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 35,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline2.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
