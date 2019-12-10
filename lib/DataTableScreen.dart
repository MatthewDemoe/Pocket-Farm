//referenced this: https://www.youtube.com/watch?v=ktTajqbhIcY

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pocket_farm/Inventory.dart';

class TableScreen extends StatefulWidget {
  TableScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TableScreen createState() => _TableScreen();
}

class _TableScreen extends State<TableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: DataTable(
          columns: [
            DataColumn(label: Text(FlutterI18n.translate(context, "words.item"))),
            DataColumn(label: Text(FlutterI18n.translate(context, "words.current"))),
            DataColumn(label: Text(FlutterI18n.translate(context, "words.lifetime"))),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.carrotSeeds"))),
              DataCell(Text(Inventory.instance().carrotSeeds.toString())),
              DataCell(Text(Inventory.instance().lifetimeCarrotSeeds.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.cabbageSeeds"))),
              DataCell(Text(Inventory.instance().cabbageSeeds.toString())),
              DataCell(Text(Inventory.instance().lifetimeCabbageSeeds.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.kaleSeeds"))),
              DataCell(Text(Inventory.instance().kaleSeeds.toString())),
              DataCell(Text(Inventory.instance().lifetimeKaleSeeds.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.grownCarrots"))),
              DataCell(Text(Inventory.instance().grownCarrots.toString())),
              DataCell(Text(Inventory.instance().lifetimeGrownCarrots.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.grownCabbages"))),
              DataCell(Text(Inventory.instance().grownCabbages.toString())),
              DataCell(Text(Inventory.instance().lifetimeGrownCabbages.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.grownKale"))),
              DataCell(Text(Inventory.instance().grownkale.toString())),
              DataCell(Text(Inventory.instance().lifetimeGrownKale.toString())),
            ]),
            DataRow(cells: [
              DataCell(Text(FlutterI18n.translate(context, "words.money"))),
              DataCell(Text(Inventory.instance().dollars.toString())),
              DataCell(Text(Inventory.instance().lifetimeDollars.toString())),
            ]),
          ],
        ),
      ),
    );
  }
}
