import 'package:flutter/material.dart';
import '../widgets/labelTextField.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xFFEFFCEF),
              Color(0xFF94D3AC),
            ])),
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: deviceHeight / 5, bottom: 50, left: 20, right: 20),
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
              Center(
                  child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 25),
                height: 350,
                decoration: BoxDecoration(
                  color: Color(0xFF655C56),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LabelTextField(
                        labelText: 'Username',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      LabelTextField(
                        labelText: 'Password',
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          print('adads');
                        },
                        child: Center(
                          child: Text(
                            'Create account to get started !',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xffEFFCEF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RaisedButton(
                          onPressed: () {},
                          color: Color(0xFFEFFCEF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 35),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF655C56)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
