import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:pocket_farm/Plants.dart';
import 'package:pocket_farm/ShopItem.dart';
import 'package:pocket_farm/Inventory.dart';
import 'package:pocket_farm/ShopScreen.dart';
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
  SeedMarker seeds = new SeedMarker(); //list to hold the ungrabbed seeds from the map
  int numFields = 5;
  int counter = 0;
  bool showBar = false;
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

  //the dialogue that shows up to prompt the user to harvest
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
            getImage('assets/images/carrot.png', BoxFit.cover, 0.5),
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
        setState(() {
          plot.showProgressBar = false;
          plot.signpostImage= getImage(plot.signpost[3], BoxFit.cover, 6); 
        });
        
      break;
      case false:
      break;
    }

  }

  //the dialogue that shows up to say to the user that the plant isn't ready to harvest
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
            getImage(plot.isSprouted() ? 'assets/images/sprout.png' : 'assets/images/dirt.png', BoxFit.cover, 0.5),
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

  //the dialogue that allows the user to pick a seed
  Future<void> _seedPicker(FarmPlot plot) async{
    switch (await showDialog<SeedType>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(FlutterI18n.translate(context, "words.selectseed")),
          children: [
            getImage('assets/images/dirt.png', BoxFit.cover, 0.5),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.carrot);
              },
              child: Text(FlutterI18n.translate(context, "words.carrot") +  " (${Inventory.instance().carrotSeeds} " + FlutterI18n.translate(context, "words.seeds") + ")"),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.cabbage);
              },
              child: Text(FlutterI18n.translate(context, "words.cabbage") +  " (${Inventory.instance().cabbageSeeds} " + FlutterI18n.translate(context, "words.seeds") + ")"),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, SeedType.kale);
              },
              child: Text(FlutterI18n.translate(context, "words.kale") +  " (${Inventory.instance().kaleSeeds} " + FlutterI18n.translate(context, "words.seeds") + ")"),
            ),
          ]
        );
      }
    )){
      case SeedType.carrot:
      if(Inventory.instance().carrotSeeds != 0) {
        plantSeeds(plot, SeedType.carrot, Carrot().minutesToGrow, 0);
        break;
      }
      else {
        //send a notification that they have no carrots
        _displayNotification('Uh oh!', FlutterI18n.translate(context, "words.noSeeds"));
        break;
      }
      break;

      case SeedType.cabbage:
      if(Inventory.instance().cabbageSeeds != 0) {
        plantSeeds(plot, SeedType.cabbage, Cabbage().minutesToGrow, 1);
        break;
      }
      else {
        //send a notification that they have no cabbages
        _displayNotification('Uh oh!', FlutterI18n.translate(context, "words.noSeeds"));
        break;
      }
      break;

      case SeedType.kale:
      if(Inventory.instance().kaleSeeds != 0) {
        plantSeeds(plot, SeedType.kale, Kale().minutesToGrow, 2);
        break;
      }
      else {
        //send a notification that they have no kale
        _displayNotification('Uh oh!', FlutterI18n.translate(context, "words.noSeeds"));
        break;
      }
      break;
    }
  }

  //the necessary steps to plant the seeds
  void plantSeeds(FarmPlot plot, SeedType theType, int time, int artIndex)
  {
    plot.plantSomething(theType); 
    Inventory.instance().plantSeed(theType); //decrease kale seeds
    _setProgressBars(plot, time, artIndex);
  }

  Column buildRows() {
    List<Row> rows = new List<Row>();

    for (int i = 0; i < numFields; i++) {
      if ((i % 2) == 0) {
        rows.add(new Row(     
          children: [
                Container(
                  height:130,
                  width:195,
                  child: Column(children: <Widget>[
                  Row(children: <Widget>[
                      farmPlots[i].gestureDetector,
                      farmPlots[i].signpostImage,
                    ],
                  ),
                  if(farmPlots[i].showProgressBar)
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
                  width:195,
                  child: Column(children: <Widget>[
                    Row(children: <Widget>[
                      farmPlots[i].gestureDetector,
                      farmPlots[i].signpostImage,
                    ],
                  ),
                  if(farmPlots[i].showProgressBar)
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
                padding: EdgeInsets.all(1.0),
              ))
          .toList(),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  //function to send over the list of ungrabbed seeds with navigator
  void sendSeeds() async {
    //await the ungrabbed seeds
    SeedMarker temp = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorldMapScreen(currentSeeds: seeds)) //send seeds
    );
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

      theFarmPlot.showProgressBar = true;
      //Creates the right progress bar
      theFarmPlot.theProgress = new FAProgressBar(
        animatedDuration: Duration(seconds: theTime), //based off plant grow time
        size: 8,
        currentValue: theTime, 
        maxValue: theTime, //current / max = endValue, as per the plugin
        borderRadius: 1,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.down,
        changeColorValue: theTime,
        backgroundColor: Colors.white,
        progressColor: Colors.red,
        changeProgressColor: Colors.blue,
      );

      //sets the signpost
      theFarmPlot.chosenPlant = plant;
      theFarmPlot.signpostImage= getImage(theFarmPlot.signpost[theFarmPlot.chosenPlant], BoxFit.cover, 6);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    while (farmPlots.length < numFields) {
      FarmPlot temp;

      farmPlots.add(temp = new FarmPlot(gestureDetector: new GestureDetector(
        child: getImage('assets/images/Land.png', BoxFit.cover, 3),      
        onTap: () => _pickDialogue(temp),
        ),     
        ),
      );
      int index = farmPlots.length-1;
      farmPlots[index].signpostImage= getImage(farmPlots[index].signpost[farmPlots[index].chosenPlant], BoxFit.cover, 6);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "words.theFarm")),
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
            children: <Widget>[getImage('assets/images/TheBarn.png', BoxFit.none, 2.4),     
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
          Container(
        height: 130.0,
        child: DrawerHeader(
            child: getImage('assets/images/menu.png', BoxFit.fitHeight,1),
            ),
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/mapicon.png', BoxFit.scaleDown, 3.0,),
              onTap: () => sendSeeds(),
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/shopicon.png',BoxFit.scaleDown,1),
              onTap: () => Navigator.pushNamed(context, '/shop'),
            ),
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/tableicon.png', BoxFit.cover, 1),
              onTap: () => Navigator.pushNamed(context, '/table'),
            ),
            alignment: Alignment.center,
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/charticon.png', BoxFit.cover,1),
              onTap: () => Navigator.pushNamed(context, '/chart'),
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  //a way to simplify all the code for getting images
  Image getImage(String address, BoxFit fit, double theScale)
  {
    return Image.asset(address, fit: fit, scale: theScale,);
  }
}
