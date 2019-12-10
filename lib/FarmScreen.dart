import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:pocket_farm/Plants.dart';
import 'package:pocket_farm/ShopItem.dart';
import 'package:pocket_farm/Inventory.dart';
import 'Enums.dart';
import 'FarmPlot.dart';
import 'WorldMapScreen.dart';
import 'notifications.dart';
import 'Player.dart';
import 'CloudStorage.dart';
import 'FarmPlot.dart';
import 'GameData.dart';
import 'Database.dart';

import 'WorldMap_Player&SeedData.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:async';

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
  Inventory inventory = new Inventory();

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
        plot.harvestPlant();
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
            child: Text(FlutterI18n.translate(context, "words.useFertilizer")),
            onPressed: () { 
              _displayNotification(FlutterI18n.translate(context, "words.fertilizerNotification"), FlutterI18n.translate(context, "words.checkBack")); 
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
                _setProgressBars(plot, Carrot().minutesToGrow~/2, 0);
              },
              child: Text(FlutterI18n.translate(context, "words.carrot") +  " (${inventory.carrotSeeds} " + FlutterI18n.translate(context, "words.seeds") + ")"),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.cabbage);
                _setProgressBars(plot, Cabbage().minutesToGrow~/2, 1);
              },
              child: Text(FlutterI18n.translate(context, "words.cabbage") +  " (${inventory.cabbageSeeds} " + FlutterI18n.translate(context, "words.seeds") + ")"),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.kale);
                _setProgressBars(plot, Kale().minutesToGrow~/2, 2);
              },
              child: Text(FlutterI18n.translate(context, "words.kale") +  " (${inventory.kaleSeeds} " + FlutterI18n.translate(context, "words.seeds") + ")"),
            ),
          ]
        );
      }
    )){
      case SeedType.carrot:
      if(inventory.carrotSeeds != 0) {
        plot.plantSomething(SeedType.carrot);
        inventory.carrotSeeds--; //decrease carrot seeds
        break;
      }
      else {
        //send a notification that they have no carrots
        _displayNotification('Uh oh!', 'You do not have enough carrot seeds!');
        break;
      }
      break;

      case SeedType.cabbage:
      if(inventory.cabbageSeeds != 0) {
        plot.plantSomething(SeedType.cabbage);
        inventory.cabbageSeeds--; //decrease cabbage seeds
        break;
      }
      else {
        //send a notification that they have no cabbages
        _displayNotification('Uh oh!', 'You do not have enough cabbage seeds!');
        break;
      }
      break;

      case SeedType.kale:
      if(inventory.kaleSeeds != 0) {
        plot.plantSomething(SeedType.kale); 
        inventory.kaleSeeds--; //decrease kale seeds
        break;
      }
      else {
        //send a notification that they have no kale
        _displayNotification('Uh oh!', 'You do not have enough kale seeds!');
        break;
      }
      break;
    }
  }

  Column buildRows() {
    List<Row> rows = new List<Row>();

    for (int i = 0; i < numFields; i++) {
      if ((i % 2) == 0) {
        rows.add(new Row(     
          children: [
                Container(
                  height:130,
                  width:200,
                  child: Column(children: <Widget>[
                  Row(children: <Widget>[
                      farmPlots[i].gestureDetector,
                      farmPlots[i].signpostImage,
                    ],
                  ),
                  Flexible(
                    child: farmPlots[i].theProgress,
                  ),
                  ],
                )
              ),                 
            ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
        ));
        } else {
        int t = i ~/ 2;
        rows[t].children.add( Container(
                  height:130,
                  width:200,
                  child: Column(children: <Widget>[
                    Row(children: <Widget>[
                      farmPlots[i].gestureDetector,
                      farmPlots[i].signpostImage,
                    ],
                  ),
                  Flexible(
                    child: farmPlots[i].theProgress,
                  ),
                  ],
                )
              ),         
          );
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

  SeedMarker seeds = new SeedMarker(); //list to hold the ungrabbed seeds from the map

  //function to send over the list of ungrabbed seeds with navigator
  void sendSeeds() async {
    //await the ungrabbed seeds
    SeedMarker temp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorldMapScreen(currentSeeds: seeds)) //send seeds
    );

    seeds.seedList = temp.seedList; //fill the seeds list with the ungrabbed seeds
    inventory.carrotSeeds += temp.totalCarrotSeeds; //increment carrot seeds from map
    inventory.cabbageSeeds += temp.totalCabbageSeeds; //increment cabbage seeds from map
    inventory.kaleSeeds += temp.totalKaleSeeds; //increment kale seeds from map

  }  

  void _displayNotification(String title, String message) {
    _notifications.sendNotificationNow(title, message, 'payload');
  }

  void _save()
  {
    saveData();
  }

  void _load() async
  {
    //farm = await farm();
    loadData();
    print(gamedata);
  }

  void _cloudSave()
  {
    saveDataCloud(gamedata);
  }

  void _cloudLoad()
  {
      cloudLoad();
  }

  void _setProgressBars(FarmPlot theFarmPlot, int theTime, int plant)
  {
    setState(() {
      //Creates the right progress bar
      theFarmPlot.theProgress = new FAProgressBar(
        size: 8,
        currentValue: 10, 
        maxValue: 10, 
        borderRadius: 1,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.down,
        animatedDuration: Duration(minutes: theTime),
        changeColorValue: 5,
        backgroundColor: Colors.white,
        progressColor: Colors.yellow,
        changeProgressColor: Colors.blue,
      );

      //sets the signpost
      theFarmPlot.chosenPlant = plant;
      theFarmPlot.signpostImage= Image.asset(
          theFarmPlot.signpost[theFarmPlot.chosenPlant], 
          scale: 4.2, 
          fit: BoxFit.cover,
      );
    });
    
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
      
        onTap: () => {
          _pickDialogue(temp),
        },
        ),
        theProgress: new FAProgressBar(
        size: 8,
        currentValue: 0,
        maxValue: 10, 
        animatedDuration: const Duration(minutes: 5),
        progressColor: Colors.red,
        ),        
        ),
      );
      int index = farmPlots.length-1;
      farmPlots[index].signpostImage= Image.asset(
          farmPlots[index].signpost[farmPlots[index].chosenPlant], 
          scale: 4.2, 
          fit: BoxFit.cover,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('The Farm'),
        actions: <Widget>[
          // saves the game to a local database
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _save,
          ),
          // loads from database
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _load,
          ),
          // saves the game to the cloud
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: _cloudSave,
          ),
          // loads the game from the cloud
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: _cloudLoad,
          )
        ],
      ),
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grass.png'),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: ListView(children: [
          Container(
            width: 300,
            height: 300,
            
          child: Row(
            children: <Widget>[
              Image.asset(    
                'assets/images/TheBarn.png',
                width:400,
                height:200,
            ),         
          ],
          ),
          ),    
          
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
          /*Container(
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
          ),*/
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Image.asset(
                'assets/images/mapicon.png',
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
                'assets/images/shopicon.png',
                fit: BoxFit.scaleDown,
              ),
              onTap: () => Navigator.pushNamed(context, '/shop'),
            ),
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Image.asset(
                'assets/images/tableicon.png',
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
                'assets/images/charticon.png',
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
