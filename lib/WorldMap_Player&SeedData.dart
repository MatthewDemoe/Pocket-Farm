import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:pocket_farm/GameData.dart';
import 'Enums.dart';
import 'Inventory.dart';

import 'GameData.dart';

//map player class
class PlayerMapData {
  LatLng position; //the position of the player on the map
  double radius; //radius will determine how far a seed can spawn from the player

  //constructor to initialize the radius, location will be set by geolocator
  PlayerMapData(this.radius);
}

//seed class
class SeedMapData {
  Marker theMarker; //each seed will have a marker to put on the map
  int id; //what type of seed it is: 0 for carrot, 1 for cabbage, 2 for kale
}

//seedMarker class to generate seeds markers on the map
class SeedMarker {
  List<SeedMapData> seedList = []; //list of seeds
  bool hasCabbageUnlocked = false;
  bool hasKaleUnlocked = false;
  int totalCarrotSeeds = 0, totalCabbageSeeds = 0, totalKaleSeeds = 0;

  //function to determine the seed that will spawn
  int determineSeed()
  {
    if (gamedata.moreSeedsLevel == 0) {
      return 0;
    }
    else if (gamedata.moreSeedsLevel == 1) {
      int temp;
      var randomizer = new Random();
      temp = randomizer.nextInt(2);
      return temp;
    }
    else if (gamedata.moreSeedsLevel >= 2) {
      int temp;
      var randomizer = new Random();
      temp = randomizer.nextInt(3);
      return temp;
    }
    else
    return null;
  }

  //addMarker function
  void addMarker(PlayerMapData player, double radiusX, double radiusY)
  {
    //generate a new seed
    SeedMapData newSeed = new SeedMapData();

    //determine what kind of seed will spawn
    newSeed.id = determineSeed();

    //spawn a carrot
    if (newSeed.id == 0) {
    //create a marker for the seed
      Marker temp = new Marker (
        width: 50, //width
        height: 50, //height
        //create the position of the seed using player position and randomized radius offsets
        point: new LatLng(player.position.latitude - radiusX, player.position.longitude - radiusY),
        builder: (context) => Container (
          child: GestureDetector (
            //create the iconbutton
            child: Image.asset (
              'assets/images/pouch0.png',
            ),
            onTap: () {
              Inventory.instance().addSeed(SeedType.carrot, 1);
              removeSeed(newSeed); //remove the seed from the list of seeds/map
            }
          ),
        ),
      );
      //set the new seeds marker to the generated marker
      newSeed.theMarker = temp;
    }
    //spawn a cabbage
    else if (newSeed.id == 1) {
      //create a marker for the seed
      Marker temp = new Marker (
        width: 50, //width
        height: 50, //height
        //create the position of the seed using player position and randomized radius offsets
        point: new LatLng(player.position.latitude - radiusX, player.position.longitude - radiusY),
        builder: (context) => Container (
          child: GestureDetector (
            //create the iconbutton
            child: Image.asset (
              'assets/images/pouch1.png',
            ),
            onTap: () {
              Inventory.instance().addSeed(SeedType.cabbage, 1);
              removeSeed(newSeed); //remove the seed from the list of seeds/map
              }
          ),
        ),
      );

      //set the new seeds marker to the generated marker
      newSeed.theMarker = temp;
    }
    //spawn a kale
    else if (newSeed.id == 2) {
      //create a marker for the seed
      Marker temp = new Marker (
        width: 50, //width
        height: 50, //height
        //create the position of the seed using player position and randomized radius offsets
        point: new LatLng(player.position.latitude - radiusX, player.position.longitude - radiusY),
        builder: (context) => Container (
          child: GestureDetector (
            //create the iconbutton
            child: Image.asset (
              'assets/images/pouch2.png',
            ),
            onTap: () {
              Inventory.instance().addSeed(SeedType.kale, 1);
              removeSeed(newSeed); //remove the seed from the list of seeds/map
            }
          ),
        ),
      );

      //set the new seeds marker to the generated marker
      newSeed.theMarker = temp;
    }
    
    //add the new seed to the list of seeds 
    seedList.add(newSeed);
  }

  //removeSeed function
  void removeSeed(SeedMapData data) {
    if (data.id == 0)
      totalCarrotSeeds++; //increment total carrots collected
    else if (data.id == 1)
      totalCabbageSeeds++; //increment total cabbages collected
    else if (data.id == 2)
      totalKaleSeeds++; //increment total kales collected

    seedList.remove(data); //remove the passed seed and it's data from the list of seeds
  }
}