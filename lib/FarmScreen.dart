import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'Enums.dart';
import 'FarmPlot.dart';
import 'package:flutter_map/flutter_map.dart';
import 'WorldMapScreen.dart';
import 'notifications.dart';

import 'WorldMap_Player&SeedData.dart';

///////////////////////////////////////////////

//final _scaffoldKey = GlobalKey<ScaffoldState>();

/*final snackBar = SnackBar(
  content: Text('Snacks'),
  action: SnackBarAction(
    label: 'Back',
    onPressed: () {},
  ),
);*/

//to show it
//_scaffoldKey.currentState.showSnackBar(snackBar);

//////////////////////////////////////////////

class FarmScreen extends StatefulWidget {
  FarmScreen({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _FarmScreen createState() => _FarmScreen();
}

final snackBar = SnackBar(
  behavior: SnackBarBehavior.floating,
  content: Text('Snacks'),
  action: SnackBarAction(
    label: 'Back',
    onPressed: () {},
  ),
);

class _FarmScreen extends State<FarmScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();  
  int numFields = 5;
  int counter = 0;
  //List<GestureDetector> fields = new List<GestureDetector>();
  List<FarmPlot> farmPlots = new List<FarmPlot>();
  var _notifications = Notifications();

  @override void initState() {
    super.initState();
    _notifications.init();
    _scheduleTick();
  }

  void _tick(Duration timestamp){
    

    _scheduleTick();
  }

  //Taken from flame's game loop
  void _scheduleTick(){
    SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  void _pickDialogue(FarmPlot plot){
    if(!plot.isPlanted())
    {
      _seedPicker(plot);
    }

    else
    {
      _checkOnPlant(plot);
    } 
  }

  void _checkOnPlant(FarmPlot plot)
  {
    if(plot.isReadyToPick())
    {
      _harvestPlant(plot);
    }

    else
    {
      _notReadyToHarvest(plot);
    }
  }

  Future<void> _harvestPlant(FarmPlot plot) async
  {
    switch(await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(FlutterI18n.translate(context, "words.readytoharvest")),
          children: [
            Image.asset('assets/images/carrot.png',
            fit: BoxFit.cover,     
            scale: 0.5,       
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, true);
              },
              child: Text(FlutterI18n.translate(context, "words.harvestchoice")),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: Text(FlutterI18n.translate(context, "words.leavechoice")),
            ),
          ]
        );
      }
    )){
      case true:
      break;
      case false:
      break;
    }

  }

  Future<void> _notReadyToHarvest(FarmPlot plot) async
  {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),  
          title: plot.isSprouted() ? Text(FlutterI18n.translate(context, "words.onlysprouted")) : Text(FlutterI18n.translate(context, "words.notgrowing")),
          children: [
            Image.asset( plot.isSprouted() ? 'assets/images/sprout.png' : 'assets/images/dirt.png',
            fit: BoxFit.cover,     
            scale: 0.5,       
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, true);
              },
              child: Text(FlutterI18n.translate(context, "words.okay")),
            ),
            SimpleDialogOption(
            child: const Text('Use Fertilizer'),
            onPressed: () { 
              _displayNotification("You used fertilizer", "check back later"); 
              Navigator.pop(context, true);
              },
          ),
          ]
        );
      }
    );
  }

  Future<void> _seedPicker(FarmPlot plot) async{
    switch (await showDialog<SeedType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(FlutterI18n.translate(context, "words.selectseed")),
          children: [
            Image.asset('assets/images/dirt.png',
            fit: BoxFit.cover,     
            scale: 0.5,       
            ),
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
      plot.plantSomething(SeedType.carrot);
      print('carrot planted');
      break;

      case SeedType.cabbage:
      plot.plantSomething(SeedType.cabbage);
      print('cabbage planted');
      break;

      case SeedType.kale:
      plot.plantSomething(SeedType.kale);
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
            farmPlots[i].gestureDetector,
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
        ));
      } else {
        int t = i ~/ 2;
        rows[t].children.add(farmPlots[i].gestureDetector);
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

  var seeds; //list to hold the ungrabbed seeds from the map

  //function to send over the list of ungrabbed seeds with navigator
  void sendSeeds() async {
    //await the ungrabbed seeds
    var temp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorldMapScreen(currentSeeds: seeds)) //send seeds
    );

    seeds = temp; //fill the seeds list with the ungrabbed seeds
  }

  void _displayNotification(String title, String message) {
    _notifications.sendNotificationNow(title, message, 'payload');
  }

  @override
  Widget build(BuildContext context) {
    while (farmPlots.length < numFields) {
      FarmPlot temp;

      farmPlots.add(temp = new FarmPlot(gestureDetector: new GestureDetector(
        child: Image.asset(
          'assets/images/Land.png',
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => _pickDialogue(temp),//() => _seedPicker(),
      )));
      /*fields.add(new GestureDetector(
        child: Image.asset(
          'assets/images/Land.png',
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => _seedPicker(),//() => {print('tapped land $counter'), counter++},
      ));*/
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('The Farm'),
      ),
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grass.jpg'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: ListView(children: [
          Container(
            width: 800,
            height: 300,
          child: Row(
            children: <Widget>[
              Image.asset(    
                'assets/images/TheBarn.png',
                alignment: Alignment.bottomLeft,
                height:200,
                width:190,
            ),
            Image.asset(
                'assets/images/House.png',
                alignment: Alignment.bottomRight,
                height:200,
                width:190,
            ),
                     
          ],
          ),),
          
          buildRows(),
          Container(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              onPressed: () {
                _scaffoldKey.currentState.showSnackBar(snackBar);
              },
              child: Text('Snackbar'),
            ),
          ),
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
                'assets/images/MapButton.png',
                fit: BoxFit.scaleDown,
                scale: 3.0,
              ),
              onTap: () => sendSeeds(),
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Image.asset(
                'assets/images/ShopButton.png',
                fit: BoxFit.scaleDown,
              ),
              onTap: () => Navigator.pushNamed(context, '/shop'),
            ),
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Image.asset(
                'assets/images/kale.png',
                fit: BoxFit.cover,
              ),
              onTap: () => Navigator.pushNamed(context, '/table'),
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Image.asset(
                'assets/images/carrot.png',
                fit: BoxFit.cover,
              ),
              onTap: () => Navigator.pushNamed(context, '/chart'),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
