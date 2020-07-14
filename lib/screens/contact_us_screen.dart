import 'package:flutter/material.dart';

import '../widgets/contactTextField.dart';

class ContactUsScreen extends StatelessWidget {
  static const routeName = '/contact-us';

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            'Contact us',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );

    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              height: 130,
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/resize-contact-us.png",
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      20,
                    ),
                    topRight: Radius.circular(
                      20,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 25,
                  ),
                  child: ListView(
                    children: <Widget>[
                      ContactTextField(
                        title: 'Phone number',
                        description: "+66 0947708689",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ContactTextField(
                        title: 'Email',
                        description: "recycle_hub@gmail.com",
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ContactTextField(
                        title: 'Address',
                        description:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Molestie amet nec leo sem dignissim ut.",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
