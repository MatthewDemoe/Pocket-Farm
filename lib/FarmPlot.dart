import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pocket_farm/GameData.dart';
import 'Enums.dart';
import 'package:flutter/material.dart';
import 'dart:async';


import 'Inventory.dart';
import 'Plants.dart';
class FarmPlot{

  //used variables
  Plant plant;
  List<String> signpost = [
  "assets/images/sp0.png",
  "assets/images/sp1.png",
  "assets/images/sp2.png",
  "assets/images/signpost.png",
  ];

  DateTime timeHalfCompleted;
  DateTime timeCompleted; 

  GestureDetector gestureDetector;
  FAProgressBar theProgress = new FAProgressBar();
  Image signpostImage; 
  int progressTimer = 0, chosenPlant = 3;
  Timer growTimer;
  bool showProgressBar = false;

  FarmPlot({this.gestureDetector, this.theProgress, this.signpostImage});

  SeedType plantedSeed;

  bool plantSomething(SeedType seed)
  {
    if(plant != null)
      return false;

    //establishes the time it would take for the seed to grow
    switch(seed)
    {
      case SeedType.carrot:
      plant = new Carrot();
      chosenPlant=0;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (plant.minutesToGrow ~/ 2))); //change from seconds back to minutes after presentation
      timeCompleted = new DateTime.now().add(new Duration(seconds: plant.minutesToGrow));
      plantedSeed = SeedType.carrot;
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
      chosenPlant=1;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: plant.minutesToGrow));
      plantedSeed = SeedType.cabbage;
      break;

      case SeedType.kale:
      plant = new Kale();
      chosenPlant=2;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: plant.minutesToGrow));
      plantedSeed = SeedType.kale;
      break;
    }

    return true;
  }

  //harvests the plant
  void harvestPlant()
  {
    if(isReadyToPick())
    {
      Inventory.instance().harvestPlant(plantedSeed);

      plant = null;
    }
  }

  //checks if the seed is planted
  bool isPlanted()
  {
    if(plant == null)
      return false;

    return true;
  }

  //checks if the seed is ready to be picked
  bool isReadyToPick()
  {
    if(isPlanted())
    {
      if(DateTime.now().isAfter(timeCompleted))
        return true;
    }  

    return false;
  }

  //check if the seed is sprouted
  bool isSprouted()
  {
    if(isPlanted())
    {
      if(DateTime.now().isAfter(timeHalfCompleted))
        return true;
    }  

    return false;
  }
}