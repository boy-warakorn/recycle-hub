import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final Icon icon;
  final String iconAlign;
  final Function onPressed;

  ButtonWithIcon({
    this.text,
    this.icon,
    this.iconAlign = "right",
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      onPressed: onPressed,
      child: Container(
        child: iconAlign == 'right'
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  icon
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  icon,
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    text,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
      ),
    );
  }
}
