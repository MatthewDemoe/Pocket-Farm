//referenced class slides on maps, geolocation, geocoding
//referenced https://stackoverflow.com/questions/54610121/flutter-countdown-timer for timers

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';
import 'WorldMap_Player&SeedData.dart';
import 'notifications.dart';

//worldmapscreen widget
class WorldMapScreen extends StatefulWidget {
  WorldMapScreen({Key key, this.title, this.currentSeeds}) : super(key: key);
  final String title;

  //currentSeeds that take in leftover seeds from last visit to mapscreen
  final SeedMarker currentSeeds; //from farm screen

  @override
  _WorldMapPage createState() => _WorldMapPage();
}

//worldmappage state
class _WorldMapPage extends State<WorldMapScreen> {

  bool notifPlayer = false;

  var playerController = MapController(); //mapcontroller to control where map is centered
  var playerLocation = Geolocator(); //geolocator

  //the player's map data, holding their position on the map
  var mapPlayer = PlayerMapData(2); //radius of 2
  //the seed data, to create various seeds using the list of seeds
  var seedData = SeedMarker();

  var playerSurroundings; //variable to hold the current street name
  var street; //variable that will collect the geocoding data

  bool onWorldMapScreen = true; //bool to check if still on world screen so geolocator stops when page is being left

  Timer spawnTimer; //timer that will countdown to spawn a seed
  double spawnTime = 15; //10 seconds for spawning additional seeds
  int seedsSpawned = 0; //the amount of seeds that have been spawned

  //geocoding function to return street names
  String checkPosition() {
    //reverse geocoding to get street names from player location
    playerLocation.placemarkFromCoordinates(mapPlayer.position.latitude, mapPlayer.position.longitude).then((List<Placemark> surroundingLoc) {
      //loop through the list of surrounding locations
      for (Placemark currentStreets in surroundingLoc) { 
        street = currentStreets.thoroughfare; //set street to current street name
      }
    });

    return street; //return the street name
  }

  //geolocation function to update/return the player's current position
  LatLng getPosition()
  {
    //geolocation to get the GPS's current position
    if (onWorldMapScreen) {
      playerLocation.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position pos) {
        setState(() {
          //update the player's latitude and longitude information
          mapPlayer.position = new LatLng(pos.latitude, pos.longitude);

          //keep the map centered on the player position at fixed zoom level
          //so they don't lose track of their player or the seeds around them
          playerController.move(mapPlayer.position, 17);
        });
      });
    }

    return mapPlayer.position; //return the latitude/longitude of the player
  }

  //function to add a seed to the map around the player's position
  void addSeed() {

    //update the player position before adding a new seed
    if(onWorldMapScreen) {
      playerLocation.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position pos) {
        setState(() {
          mapPlayer.position = new LatLng(pos.latitude, pos.longitude); //update the player position
        });
      });
    }

    //randomizer to create random spawn locations
    var randomizer = new Random();

    //create random x and y values within ranges of player radius to offset the latitude & longitude of seeds
    //generate a range of variables, subtract to allow for some negative values, then multiply by 0.00075 to scale down to latitude/longitude offsets
    var randomOffsetx = (mapPlayer.radius * (randomizer.nextDouble() * mapPlayer.radius) - mapPlayer.radius) * 0.00075;
    var randomOffsety = (mapPlayer.radius * (randomizer.nextDouble() * mapPlayer.radius) - mapPlayer.radius) * 0.00075;

    //use the addMarker function to create a new seed marker on the map
    seedData.addMarker(mapPlayer, randomOffsetx, randomOffsety); //pass player location, and random offsets
  }

  //this will increment the seed spawn timer in order to spawn seeds
  void seedSpawnTimer() async {
    
    //timer that updates every 1 second
    spawnTimer = new Timer.periodic(new Duration(seconds: 1), (Timer temp) =>
    setState(() { 

      
      //use the geocoding checkPosition function to get the current street name
      var currentSurroundings = checkPosition();
      
      //if the playersurroundings is the same as the current street (meaning they haven't moved)
      //and 10 or seeds have spawned, decrease the rate the spawnTime increases
      if (playerSurroundings == currentSurroundings && seedsSpawned >= 10) {
        spawnTime-= 0.5;
      }
      //otherwise, if the player has moved to a different street
      //update the playerSurroundings, and increase the rate the spawnTime increases
      //reset the amount of seedsSpawn if 11 or more
      //this is to encourage the player to move around to get seeds spawning more frequently
      else {
        playerSurroundings = currentSurroundings;
        spawnTime-= 1;
        if (seedsSpawned >= 11)
          seedsSpawned = 0;
      }

      //if spawnTime is depleted
      if(spawnTime <= 0) {
        addSeed(); //spawn new seed
        spawnTime = 15; //reset the time
        seedsSpawned++; //increment the amount of seeds spawned
      }
    }),
    );
  }

  //override the initState
  @override
  void initState() {
    super.initState();
    this.seedSpawnTimer(); //start the seed spawning timer on init
    //if (widget.currentSeeds != null) {
      //seedData.seedList = widget.currentSeeds.seedList; //if not null, load in the previous seeds that weren't picked up
      //for (int i = 0; i < widget.currentSeeds.seedList.length; i++) {
        //seedData.seedList[i].id = widget.currentSeeds.seedList[i].id;
      //}
    //4}
    onWorldMapScreen = true; //back on the map screen page, so true
  }

  //override the dispose
  @override
  void dispose() {
    super.dispose();
    spawnTimer.cancel(); //stop the timer when we leave the world map screen
  }

  //function to send seed data back to farm screen, to add to player inventory
  void sendSeeds() {
    onWorldMapScreen = false; //no longer on the map screen page
    
    //have a 1 second disconnect timer from the map
    //to avoid geolocator updating after changing pages
    //this will avoid memory leaks
    new Timer(new Duration(seconds: 1), () =>
    Navigator.pop(context, seedData)
    );
  }

  //notification function
  void showMapInfo() async  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container (
          width: 300,
          height: 1000,
          alignment: Alignment.center,
          //child: Image.asset(
            //'assets/images/dirt.png'
          //),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text('\nWelcome to the World Map!\n\n*Seeds will spawn periodically; they will spawn more frequently when you move around!\n\n*Make sure to grab seeds before heading back to your farm; they will despawn if you leave without grabbing them!\n\n'),
          ),
        );
      },
    );
  }

  //widget
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //back button in app bar
        leading: IconButton (
          icon: Icon(Icons.arrow_back),
          onPressed: () => sendSeeds(), //return to farm screen, send ungrabbed seeds to be reloaded once returned to map
        ),
        title: Text('The World Map'),
      ),
      body: Center(
        //create a FlutterMap to show the world map
        child: FlutterMap (
          //add the playerController as the map controller to keep centered on the player
          mapController: playerController,
          //setup the map options
          options:
          MapOptions (
            zoom: 17, //set the zoom level
            interactive: false, //interactive to false so players can't move the map away from their position
          ),
          layers: [
             //generate tile layer options using OpenStreetMap
             TileLayerOptions (
               urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
               subdomains: ['a', 'b', 'c'],
              ),
              //generate the marker layer options
              MarkerLayerOptions (
                markers: [
                  //setup the player marker
                  Marker (
                    width: 20,
                    height: 20,
                    point: getPosition(), //get the position of the player using geolocation getPosition function
                    builder: (context) => Container (
                      child: Icon(Icons.location_on) //use the icon to represent the player
                     ),
                   ),
                   //run through the list of seeds seedData holds
                   for (int i = 0; i < seedData.seedList.length; i++)
                    seedData.seedList[i].theMarker, //for each seed, pass their marker to add to the map      
                ],  
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: showMapInfo,
          tooltip: 'Display more info about the World Map',
          child: Icon(Icons.info),
        ),
    );
  }
}