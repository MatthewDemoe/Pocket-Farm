import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

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
}

//seedMarker class to generate seeds markers on the map
class SeedMarker {
  List<SeedMapData> seedList = []; //list of seeds

  //addMarker function
  void addMarker(PlayerMapData player, double radiusX, double radiusY)
  {
    //generate a new seed
    SeedMapData newSeed = new SeedMapData();

    //create a marker for the seed
    Marker temp = new Marker (
      width: 50, //width
      height: 50, //height
      //create the position of the seed using player position and randomized radius offsets
      point: new LatLng(player.position.latitude - radiusX, player.position.longitude - radiusY),
      builder: (context) => Container (
        //create the iconbutton
        child: IconButton (
          icon: Icon(Icons.photo), //placeholder icon
          color: Colors.green,
          onPressed: () {
            //NOTE: increment the amount of seeds player has once inventory is established
            print('This has removed the seed from the map, and given it to the player inventory.');
            removeSeed(newSeed); //remove the seed from the list of seeds/map
          }
        ),
      ),
    );
    //set the new seeds marker to the generated marker
    newSeed.theMarker = temp;
    //add the new seed to the list of seeds 
    seedList.add(newSeed);
  }

  //removeSeed function
  void removeSeed(SeedMapData data) {
    seedList.remove(data); //remove the passed seed and it's data from the list of seeds
  }
}