import 'package:flutter/material.dart';
import '../widgets/button/buttonWithIcon.dart';

class WasteInfoScreen extends StatefulWidget {
  static const routeName = '/wasteInfo';

  @override
  _WasteInfoScreenState createState() => _WasteInfoScreenState();
}

class _WasteInfoScreenState extends State<WasteInfoScreen> {
  var currentPage = 1;

  void nextPage() {
    setState(() {
      currentPage++;
    });
  }

  void previousPage() {
    setState(() {
      currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
              'What is ?',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: AnimatedCrossFade(
            duration: Duration(
              milliseconds: 300,
            ),
            crossFadeState: currentPage == 1
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage('assets/images/recycle_waste_1.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'What is Recycle waste ?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim non nulla odio in. Morbi dignissim interdum molestie nulla nulla. Facilisi aliquet egestas nunc aliquet cursus. Egestas at viverra posuere ornare venenatis.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ButtonWithIcon(
                  text: 'Next',
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    size: 26,
                    color: Colors.white,
                  ),
                  onPressed: this.nextPage,
                ),
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage('assets/images/recycle_waste_2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'What we consider to be Recycle waste ?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim non nulla odio in. Morbi dignissim interdum molestie nulla nulla. Facilisi aliquet egestas nunc aliquet cursus. Egestas at viverra posuere ornare venenatis.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ButtonWithIcon(
                  text: 'Back',
                  iconAlign: 'left',
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 26,
                    color: Colors.white,
                  ),
                  onPressed: this.previousPage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
