//referenced this: https://www.youtube.com/watch?v=ktTajqbhIcY

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pocket_farm/Inventory.dart';

import 'GameData.dart';

//data table screen
class TableScreen extends StatefulWidget {
  TableScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TableScreen createState() => _TableScreen();
}
//data table class that acts as inventory
class _TableScreen extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: 
        Column(
          children: <Widget>[
            Container(
              height:135,
              child: Image.asset('assets/images/inventory.png', scale: 3),
            ),
            DataTable(
            columns: [
              DataColumn(label: Text(FlutterI18n.translate(context, "words.item"))),
              DataColumn(label: Text(FlutterI18n.translate(context, "words.current"))),
            ],
            rows: [
              getRow("words.carrotSeeds", Inventory.instance().carrotSeeds.toString()),
              getRow("words.cabbageSeeds", Inventory.instance().cabbageSeeds.toString()),
              getRow("words.kaleSeeds", Inventory.instance().kaleSeeds.toString()),
              getRow("words.grownCarrots", Inventory.instance().grownCarrots.toString()),
              getRow("words.grownCabbages", Inventory.instance().grownCabbages.toString()),
              getRow("words.grownKale", Inventory.instance().grownkale.toString()),
              getRow("words.money", Inventory.instance().dollars.toString()),
            ],
          ),
          Container(
              height:120,
              child: Image.asset('assets/images/carrotGarland.png', scale: 2.3),
            ),
        ],
      ),
      ),
    );
  }

  //In order to display each section of the inventory
  DataRow getRow(String words, String info)
  {
    return DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, words))),
              DataCell(Text(info),)
    ]);
  }
}
