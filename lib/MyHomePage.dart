import 'package:flutter/material.dart';
import 'FarmScreen.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text(widget.title),
      ),*/
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/Pocket_Farm_Title.png',
            fit: BoxFit.cover,

            ),

            //Play Button
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmScreen())
                )
              },
              child: Image.asset('assets/images/PlayButton.png',
              fit: BoxFit.cover,
              scale: 2.0,
              ),
            ),

            //Exit Button
            GestureDetector(
              onTap: () => exit(0),
              child: Image.asset('assets/images/ExitButton.png',
              fit: BoxFit.cover,
              scale: 2.0,
              ),
            ),

            /*RaisedButton(
              child: Text('Exit',

              ),
              color: Colors.red,
              onPressed: () => exit(0),
            ),*/
          ],
        ),
      ),
    );
  }
}
