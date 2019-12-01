import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'dart:io';

import 'package:flutter_i18n/flutter_i18n_delegate.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool english = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.pushNamed(context, '/farm')
              },
              child: Container(
                constraints: BoxConstraints(minWidth: 120, minHeight: 60),
                decoration: BoxDecoration(color: Colors.green),
                child: Text(
                  FlutterI18n.translate(context, 'words.play'),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ),
            ),

            //Exit Button
            GestureDetector(
              onTap: () => exit(0),
              child: Container(
                constraints: BoxConstraints(minWidth: 120, minHeight: 60),
                decoration: BoxDecoration(color: Colors.red),
                child: Text(
                  FlutterI18n.translate(context, "words.exit"),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              
              children: [
                FlatButton(
                  child: Text(FlutterI18n.translate(context, "words.langbutton")),
                  onPressed: () {
                    Locale newLocale;
                if(english == true)
                {
                  newLocale = Locale('fr');
                  english = !english;
                }
                else
                {
                  newLocale = Locale('en');
                  english = !english;
                }
                setState((){
                  FlutterI18n.refresh(context, newLocale);
                });
            },
          ),
              ]
            )
          ],
        ),
      ),
    );    
  }  
}


