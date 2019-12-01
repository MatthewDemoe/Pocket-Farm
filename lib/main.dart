import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

import 'package:pocket_farm/FarmScreen.dart';
import 'package:pocket_farm/WorldMapScreen.dart';
import 'MyHomePage.dart';
import 'FarmScreen.dart';
import 'ShopScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: false,
          fallbackFile: 'fr',
          path: 'assets/i18n',
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: "Pocket Farm",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Countryside',
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/farm' : (context) => FarmScreen(), 
        '/shop' : (context) => ShopScreen(),
      },
    );
  }
}

