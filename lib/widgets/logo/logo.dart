import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          top: deviceHeight / 5, bottom: 25, left: 20, right: 20),
      child: Image(
        image: AssetImage('assets/images/logo.png'),
      ),
    );
  }
}
