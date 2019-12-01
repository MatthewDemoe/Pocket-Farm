import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'Enums.dart';


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

  @override void initState() {
    super.initState();
    _scheduleTick();
  }

  void _tick(Duration timestamp){

    _scheduleTick();
  }

  //Taken from flame's game loop
  void _scheduleTick(){
    SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  Future<void> _seedPicker() async{
    switch (await showDialog<SeedType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(FlutterI18n.translate(context, "words.selectseed")),
          children: [
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.carrot);
              },
              child: Text(FlutterI18n.translate(context, "words.carrot")),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.cabbage);
              },
              child: Text(FlutterI18n.translate(context, "words.cabbage")),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.kale);
              },
              child: Text(FlutterI18n.translate(context, "words.kale")),
            ),
          ]
        );
      }
    )){
      case SeedType.carrot:
      print('carrot planted');
      break;

      case SeedType.cabbage:
      print('cabbage planted');
      break;

      case SeedType.kale:
      print('kale planted');
      break;
    }

  }

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
        onTap: () => _seedPicker(),//() => {print('tapped land $counter'), counter++},
      ));
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grass.jpg'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: ListView(children: [
          Image.asset(
            'assets/images/Farm.png',
            alignment: Alignment.topCenter,
            fit: BoxFit.scaleDown,
            scale: 0.5,
          ),
          buildRows(),
        ]),
      ),

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
