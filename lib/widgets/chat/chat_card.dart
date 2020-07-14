import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: Ink(
              height: 80,
              width: double.infinity,
              child: Ink(
                padding: EdgeInsets.all(
                  15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Warakorn st.',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          '10.00 AM',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontSize: 10,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Hello. I want to sell 10kg of card...',
                      style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Color(0xFF464646),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
