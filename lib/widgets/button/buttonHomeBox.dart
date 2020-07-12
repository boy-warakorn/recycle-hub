import 'package:flutter/material.dart';

class ButtonHomeBox extends StatelessWidget {
  final Icon icon;
  final String text;
  final double width;
  final double height;
  final Function onTap;

  ButtonHomeBox({
    this.icon,
    this.text,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: InkWell(
        splashColor: Color(0xFFEFFCEF),
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              icon,
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
