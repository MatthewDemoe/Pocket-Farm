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
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:300,
              width:350,
              child: Image.asset('assets/images/Pocket_Farm_Title.png',
              fit: BoxFit.cover,            
              ),
            ),
            //Play Button
            Container(
              height:150,
              width:350,
              child: GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, '/farm')
                },
                child: 
                Stack(
                  children: <Widget>[
                  Center(child:Image.asset('assets/images/carrotbutton.png')),
                  Center(child:Text(
                    FlutterI18n.translate(context, 'words.play'),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2.4,
                  ),),
                ]
              )
            ),
            ),
            //Exit Button
            Container(
              height:125,
              width:350,
              child: GestureDetector(
                onTap: () => exit(0),
                child: Stack(
                    children: <Widget>[
                    Center(child:Image.asset('assets/images/carrotbutton.png')),
                    Center(child: Text(
                    FlutterI18n.translate(context, "words.exit"),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 2.4,
                  ),
                ),],
            ),),),
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


