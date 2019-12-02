//reference https://google.github.io/charts/flutter/example/axes/custom_font_size_and_color.html
//reference https://google.github.io/charts/flutter/example/bar_charts/simple

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';

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
      body: Chart.seedData(),
    );
  }
}

class Chart extends StatelessWidget {
  final List<Series> seriesList;
  final bool animate;

  Chart(this.seriesList, {this.animate});

  factory Chart.seedData() {
    return new Chart(
      _createSeedData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BarChart(seriesList,
        animate: animate,
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
    );

        
  }

  static List<Series<Foods, String>> _createSeedData() {
    final data = [
      new Foods('Carrot', 5),
      new Foods('Cabbage', 25),
      new Foods('Kale', 100),
    ];

    return [
      new Series<Foods, String>(
        id: 'Grown',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (Foods food, _) => food.name,
        measureFn: (Foods food, _) => food.amount,
        data: data,
      )
    ];
  }
}

class Foods {
  final String name;
  final int amount;

  Foods(this.name, this.amount);
}
