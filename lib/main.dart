import 'package:flutter/material.dart';
import 'package:pocket_farm/FarmScreen.dart';
import 'package:pocket_farm/WorldMapScreen.dart';
import 'MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Farm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pocket Farm'),
    );
  }
}

