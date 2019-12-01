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
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('This is a farm :)'),
            RaisedButton(onPressed: () {
              _scaffoldKey.currentState.showSnackBar(snackBar);
            })
          ],
        ),
      ),
      drawer: ListView(
        padding: EdgeInsets.only(right: 200.0),
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
              child: Icon(Icons.map),
              onTap: () => sendSeeds(),
            ),
          ),
        ],
      ),
    );
  }
}
