//reference https://google.github.io/charts/flutter/example/axes/custom_font_size_and_color.html
//reference https://google.github.io/charts/flutter/example/bar_charts/simple

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:path/path.dart';

import 'GameData.dart';
import 'Inventory.dart';

//ChartScreen
class ChartScreen extends StatefulWidget {
  ChartScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChartScreen createState() => _ChartScreen();
}

class _ChartScreen extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chart.seedData(context),
    );
  }
}

//the crops that will be displayed
class Crops {
  final String foodType;
  final int totalOfFood;

  Crops(this.foodType, this.totalOfFood);
}

//chart class
class Chart extends StatelessWidget {
  final List<Series> foodList;
  final bool animateChart;

  Chart(this.foodList, {this.animateChart});

  //create a factory for the data
  factory Chart.seedData(BuildContext context) {
    return new Chart(
      _createSeedData(context),
      animateChart: false,
    );
  }

  //build the chart widget
  @override
  Widget build(BuildContext context) {
    Inventory.instance().updateGameData();
    return new Center(
      child: Container(
      width: 400,
      height: 600,
      padding: EdgeInsets.all(5.0),
      child: BarChart(foodList,
        behaviors: [
          new ChartTitle(FlutterI18n.translate(context, "words.amountGrown"),
          subTitle: FlutterI18n.translate(context, "words.highscore"),
          innerPadding: 20,
          behaviorPosition: BehaviorPosition.top,
          ),
        ],
        animate: animateChart,
        domainAxis: OrdinalAxisSpec(
            renderSpec: SmallTickRendererSpec(
          labelStyle: new TextStyleSpec(
              fontSize: 18, // size in Pts.
              color: MaterialPalette.black),
        )),
        primaryMeasureAxis: NumericAxisSpec(
          renderSpec: new GridlineRendererSpec(

              // Tick and Label styling here.
              labelStyle: new TextStyleSpec(
                  fontSize: 18,
                  fontFamily: 'Roboto', // size in Pts.
                  color: MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new LineStyleSpec(
                  color: MaterialPalette.black))),
        ),
      
      ),
      );
        
  }

  //the list of how many crops have been grown
  static List<Series<Crops, String>> _createSeedData(BuildContext context) {
    final data = [
      new Crops(FlutterI18n.translate(context, "words.carrot"), gamedata.carrotsGrown),
      new Crops(FlutterI18n.translate(context, "words.cabbage"), gamedata.cabbageGrown),
      new Crops(FlutterI18n.translate(context, "words.kale"), gamedata.kayleGrown),
    ];

    return [
      new Series<Crops, String>(
        id: FlutterI18n.translate(context, "words.amountGrown"),
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (Crops food, _) => food.foodType,
        measureFn: (Crops food, _) => food.totalOfFood,
        data: data,
      )
    ];
  }
}
