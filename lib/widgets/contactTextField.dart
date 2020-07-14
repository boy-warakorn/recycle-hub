import 'package:flutter/material.dart';

class ContactTextField extends StatelessWidget {
  final String title;
  final String description;

  ContactTextField({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white,
              ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          padding: EdgeInsets.all(
            10,
          ),
          child: Text(
            description,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ],
    );
  }
}
