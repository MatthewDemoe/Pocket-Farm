import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';

import 'CloudStorage.dart';
import 'MyHomePage.dart';
import 'FarmScreen.dart';
import 'ShopScreen.dart';

void main() async {

GameData data = new GameData(
  carrotSeeds: 0,
  cabbageSeeds: 0,
  kayleSeeds: 0,
  carrots: 0,
  cabbage: 0,
  kayle: 0,
  carrotsGrown: 0,
  cabbageGrown: 0,
  kayleGrown: 0,
  p1Plant: 0,
  p2Plant: 0,
  p3Plant: 0,
  p4Plant: 0,
  p5Plant: 0,
  p1TimeLeft: 0,
  p2TimeLeft: 0,
  p3TimeLeft: 0,
  p4TimeLeft: 0,
  p5TimeLeft: 0,
  money: 0,
  fasterGrowingLevel: 0,
  betterHarvestLevel: 0,
  moreSeedsLevel: 0,
  moreMoneyFromSellingLevel: 0,
  planterBoxLevel: 0,
);

saveData(data);

  runApp(MyApp());
}

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

