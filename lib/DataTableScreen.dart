//referenced this: https://www.youtube.com/watch?v=ktTajqbhIcY

import 'package:flutter/material.dart';

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
            DataColumn(label: Text('Plant')),
            DataColumn(label: Text('Seeds')),
            DataColumn(label: Text('Harvested')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Carrots')),
              DataCell(Text("0")),
              DataCell(Text("0")),
            ]),
            DataRow(cells: [
              DataCell(Text('Cabbage')),
              DataCell(Text("0")),
              DataCell(Text("0")),
            ]),
            DataRow(cells: [
              DataCell(Text('Kale')),
              DataCell(Text("0")),
              DataCell(Text("0")),
            ])
          ],
        ),
      ),
    );
  }
}
