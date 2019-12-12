import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pocket_farm/Plants.dart';
import 'package:pocket_farm/Inventory.dart';
import 'Enums.dart';
import 'FarmPlot.dart';
import 'WorldMapScreen.dart';
import 'notifications.dart';
import 'CloudStorage.dart';
import 'GameData.dart';
import 'Database.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'dart:async';

class FarmScreen extends StatefulWidget {
  FarmScreen({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _FarmScreen createState() => _FarmScreen();
}

//farmscreen class
class _FarmScreen extends State<FarmScreen> { 
  int numFields = 5;
  int counter = 0;

  //List<GestureDetector> fields = new List<GestureDetector>();
  List<FarmPlot> farmPlots = new List<FarmPlot>();
  var _notifications = Notifications();

  //override the initState
  @override void initState() {
    super.initState();
    _notifications.init(); //initialize notifications
    _scheduleTick(); //begin scheduleTick
  }

  void _tick(Duration timestamp){
    _scheduleTick();
  }

  //Taken from flame's game loop
  void _scheduleTick(){
    SchedulerBinding.instance.scheduleFrameCallback(_tick);
  }

  //function to initiate a dialogue when players click on a farm plot
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

  //function to check if a farm plot is ready to be harvested
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
            Image.asset('assets/images/${plot.plotPlant}.png',
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
          ],
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

  //build the rows of farm plots for the farm
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
                  if(farmPlots[i].showProgressBar) //only show the progress bar when true
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
                  if(farmPlots[i].showProgressBar) //only show the progress bar when true
                    Flexible(
                      child: farmPlots[i].theProgress,
                    ),
                  ],
                )
              ),         
          );
      }
    }

    //add the rows of farm plots to a column
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

  //function to navigate to the map
  void goToMapScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorldMapScreen()) //go to map screen
    );
  }  

  //function to display notifications
  void _displayNotification(String title, String message) {
    _notifications.sendNotificationNow(title, message, 'payload');
  }

  //save function to save to local database
  void _save()
  {
    //save what is currently being grown
    gamedata.p1Plant = checkPlot(0);
    gamedata.p2Plant = checkPlot(1);
    gamedata.p3Plant = checkPlot(2);
    gamedata.p4Plant = checkPlot(3);
    gamedata.p5Plant = checkPlot(4);

    gamedata.p1TimeLeft = checkTimeRemaining(0);
    gamedata.p2TimeLeft = checkTimeRemaining(1);
    gamedata.p3TimeLeft = checkTimeRemaining(2);
    gamedata.p4TimeLeft = checkTimeRemaining(3);
    gamedata.p5TimeLeft = checkTimeRemaining(4);

    //save the game data
    saveData();
  }

  //load function to save from local database
  void _load() async
  {
    //load the game data
    loadData();
    print(gamedata);

    loadPlot(0, gamedata.p1Plant, gamedata.p1TimeLeft);
    loadPlot(1, gamedata.p2Plant, gamedata.p2TimeLeft);
    loadPlot(2, gamedata.p3Plant, gamedata.p3TimeLeft);
    loadPlot(3, gamedata.p4Plant, gamedata.p4TimeLeft);
    loadPlot(4, gamedata.p5Plant, gamedata.p5TimeLeft);

  }

  //cloudsave function to save to the cloud
  void _cloudSave()
  {
    //save what is currently being grown
    gamedata.p1Plant = checkPlot(0);
    gamedata.p2Plant = checkPlot(1);
    gamedata.p3Plant = checkPlot(2);
    gamedata.p4Plant = checkPlot(3);
    gamedata.p5Plant = checkPlot(4);

    gamedata.p1TimeLeft = checkTimeRemaining(0);
    gamedata.p2TimeLeft = checkTimeRemaining(1);
    gamedata.p3TimeLeft = checkTimeRemaining(2);
    gamedata.p4TimeLeft = checkTimeRemaining(3);
    gamedata.p5TimeLeft = checkTimeRemaining(4);

    //save the game data
    saveDataCloud(gamedata);
  }

  //cloudload function to load from the cloud
  void _cloudLoad()
  {
    //load from the cloud
    cloudLoad();

    loadPlot(0, gamedata.p1Plant, gamedata.p1TimeLeft);
    loadPlot(1, gamedata.p2Plant, gamedata.p2TimeLeft);
    loadPlot(2, gamedata.p3Plant, gamedata.p3TimeLeft);
    loadPlot(3, gamedata.p4Plant, gamedata.p4TimeLeft);
    loadPlot(4, gamedata.p5Plant, gamedata.p5TimeLeft);

  }

  int checkPlot(int index) {
    int gamePlant;

    if (farmPlots[index].plotId == index + 1)
    {
      if (farmPlots[index].seedId == 1)
      { 
        gamePlant= farmPlots[index].seedId;
        return gamePlant;
      }
      else if (farmPlots[index].seedId == 2)
      {
        gamePlant = farmPlots[index].seedId;
        return gamePlant;
      }

      else if (farmPlots[index].seedId == 3)
      {
        gamePlant = farmPlots[index].seedId;
        return gamePlant;
      }
    }
    return 0; //return 0 if no plant

  }

  int checkTimeRemaining(int index) {
    int gameTimeLeft;

    if (farmPlots[index].plotId == index + 1)
    {
      if (farmPlots[index].seedId == 1)
      { 
        gameTimeLeft = farmPlots[index].plant.secondsToGrow + DateTime.now().difference(farmPlots[index].timeCompleted).inSeconds;
        return gameTimeLeft;
      }
      else if (farmPlots[index].seedId == 2)
      {
        gameTimeLeft = farmPlots[index].plant.secondsToGrow + DateTime.now().difference(farmPlots[index].timeCompleted).inSeconds;
        return gameTimeLeft;
      }

      else if (farmPlots[index].seedId == 3)
      {
        gameTimeLeft = farmPlots[index].plant.secondsToGrow + DateTime.now().difference(farmPlots[index].timeCompleted).inSeconds;
        return gameTimeLeft;
      }
    }
    return 0; //return 0 if no plant
  }

  void loadPlot(int index, int plantType, int timeLeft) {
    if(farmPlots[index].plotId == index + 1) { //plot
        if (plantType == 1) { //grow a carrot
          setState(() {
            farmPlots[index].plantSomethingOnLoad(SeedType.carrot, timeLeft);
            _setProgressBars(farmPlots[index], timeLeft, 0);
          });
        }
        if (plantType == 2) { //grow a cabbage
          setState(() {
            farmPlots[index].plantSomethingOnLoad(SeedType.carrot, timeLeft);
            _setProgressBars(farmPlots[index], timeLeft, 1);
          });
        }
        if (plantType == 3) { //grow a kale
          setState(() {
            farmPlots[index].plantSomethingOnLoad(SeedType.carrot, timeLeft);
            _setProgressBars(farmPlots[index], timeLeft, 2);
          });
        }
    }
  }

  //function to setup the progress bars
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
  
  //build the widget for the farm screen
  @override
  Widget build(BuildContext context) {
    int id = 0;

    //initialize the farm plots to go into the farmplots list
    while (farmPlots.length < numFields) {
      FarmPlot temp;
      id++;

      //add a new farmplot to the list
      farmPlots.add(temp = new FarmPlot(gestureDetector: new GestureDetector(
        child: getImage('assets/images/Land.png', BoxFit.cover, 3),      
        onTap: () => _pickDialogue(temp),
        ),     
        ),
      );
      int index = farmPlots.length-1;
      farmPlots[index].signpostImage= getImage(farmPlots[index].signpost[farmPlots[index].chosenPlant], BoxFit.cover, 6);
      farmPlots[index].plotId = id;
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
          
          buildRows(), //build the farmplots
        ]),
      ),

      //create the drawer for the menu options
      drawer: ListView(
        padding: EdgeInsets.only(top: 100.0, right: 200.0),
        children: [
          Container(
        height: 130.0,
        child: DrawerHeader(
            child: getImage('assets/images/menu.png', BoxFit.fitHeight,1),
            ),
          ),
          Container( //map menu option
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/mapicon.png', BoxFit.scaleDown, 3.0,),
              onTap: () => goToMapScreen(), //go to the map screen
            ),
            alignment: Alignment.center,
          ),
          Container( //shop menu option
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/shopicon.png',BoxFit.scaleDown,1),
              onTap: () => Navigator.pushNamed(context, '/shop'), //go to the shop screen
            ),
          ),
          Container( //inventory menu option
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/tableicon.png', BoxFit.cover, 1),
              onTap: () => Navigator.pushNamed(context, '/table'), //go to the inventory screen
            ),
            alignment: Alignment.center,
          ),
          Container( //highscores menu option
            height: 100.0,
            child: GestureDetector(
              child: getImage('assets/images/charticon.png', BoxFit.cover,1),
              onTap: () => Navigator.pushNamed(context, '/chart'), //go to the highscores screen
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
