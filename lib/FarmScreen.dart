import 'package:flutter/material.dart';

class FarmScreen extends StatefulWidget {
  FarmScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FarmScreen createState() => _FarmScreen();
}

class _FarmScreen extends State<FarmScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('This is a farm :)'),
          ],
        ),
      ),
      drawer: ListView(
        padding: EdgeInsets.only(right: 200.0),
        children: [
          Container(
            height: 100.0,
            child: DrawerHeader(
            child: Text('Drawer Items', 
              textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}