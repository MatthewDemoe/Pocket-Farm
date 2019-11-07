import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'FarmScreen.dart';
import 'ShopScreen.dart';

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
      //home: MyHomePage(title: 'Pocket Farm'),

      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/farm' : (context) => FarmScreen(), 
        '/shop' : (context) => ShopScreen(),
      },
    );
  }
}

