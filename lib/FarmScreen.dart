import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pocket_farm/WorldMapScreen.dart';

import 'WorldMap_Player&SeedData.dart';

class FarmScreen extends StatefulWidget {
  FarmScreen({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  _FarmScreen createState() => _FarmScreen();
}

class _FarmScreen extends State<FarmScreen> {

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('This is a farm :)'),
          ],
        ),
      ),
      drawer: ListView(
        padding: EdgeInsets.only(right: 200.0),
        children: [
          Container(
            height: 100.0,
            child: DrawerHeader(
            child: Text('Drawer Items', 
              textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
            ),
          ),
          Container(
            height: 100.0,
            child: GestureDetector(
              child: Icon(Icons.map),
              onTap: () => sendSeeds(),
            ),
          ),
        ],
      ),
    );
  }
}