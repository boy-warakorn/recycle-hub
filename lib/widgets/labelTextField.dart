import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  LabelTextField({this.labelText, this.obscureText = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(
            color: Color(0xffEFFCEF),
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Container(
            height: 35,
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: TextField(
              obscureText: obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your $labelText',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
