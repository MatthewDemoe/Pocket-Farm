import 'package:flutter/material.dart';

class FarmScreen extends StatefulWidget {
  FarmScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FarmScreen createState() => _FarmScreen();
}

class _FarmScreen extends State<FarmScreen> {
  int numFields = 5;
  int counter = 0;
  List<GestureDetector> fields = new List<GestureDetector>();

  Column buildRows() {
    List<Row> rows = new List<Row>();

    for (int i = 0; i < numFields; i++) {
      if ((i % 2) == 0) {
        rows.add(new Row(
          children: [
            fields[i],
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
        ));
      } else {
        int t = i ~/ 2;
        rows[t].children.add(fields[i]);
      }
    }

    return Column(
      children: rows
          .map((row) => Container(
                child: row,
                padding: EdgeInsets.all(5.0),
              ))
          .toList(),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    while (fields.length < numFields) {
      fields.add(new GestureDetector(
        child: Image.asset(
          'assets/images/Land.png',
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => {print('tapped land $counter'), counter++},
      ));
    }

    return Scaffold(
      body: ListView(
        children: [
        Image.asset('assets/images/Farm.png', 
        alignment: Alignment.topCenter, 
        fit: BoxFit.scaleDown, 
        scale: 0.5,
        ),

        buildRows(),
        
      ]),

      drawer: ListView(
        padding: EdgeInsets.only(top: 100.0, right: 200.0),
        children: [
          Container(
            height: 100.0,
            child: DrawerHeader(
              child: Text(
                'Drawer Items',
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Image.asset(
                'assets/images/ShopButton.png',
                fit: BoxFit.cover,
              ),
              onTap: () => Navigator.pushNamed(context, '/shop'),
            ),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
