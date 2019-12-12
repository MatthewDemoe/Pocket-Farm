import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:pocket_farm/GameData.dart';
import 'Enums.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'Inventory.dart';
import 'Plants.dart';

class FarmPlot{
  Plant plant;
  List<String> signpost = [
  "assets/images/sp0.png",
  "assets/images/sp1.png",
  "assets/images/sp2.png",
  "assets/images/signpost.png",
  ];

  String plotPlant;
  int plotId, seedId;

  DateTime timeHalfCompleted;
  DateTime timeCompleted; 

  GestureDetector gestureDetector;
  FAProgressBar theProgress = new FAProgressBar();
  Image signpostImage; 
  int progressTimer = 0, chosenPlant = 3;
  Timer growTimer;
  //set up the timer stuff
  //you set off the timer stuff in the switch statement

  bool showProgressBar = false;

  FarmPlot({this.gestureDetector, this.theProgress, this.signpostImage});

  SeedType plantedSeed;

  bool plantSomething(SeedType seed)
  {
    if(plant != null)
      return false;

    switch(seed)
    {
      case SeedType.carrot:
      plant = new Carrot();
      chosenPlant=0;
      seedId = 1;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (plant.secondsToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: plant.secondsToGrow));
      plantedSeed = SeedType.carrot;
      plotPlant = 'carrot';
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
      chosenPlant=1;
      seedId = 2;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (plant.secondsToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: plant.secondsToGrow));
      plantedSeed = SeedType.cabbage;
      plotPlant = 'cabbage';
      break;

      case SeedType.kale:
      plant = new Kale();
      chosenPlant=2;
      seedId = 3;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (plant.secondsToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: plant.secondsToGrow));
      plantedSeed = SeedType.kale;
      plotPlant = 'kale';
      break;
    }

    return true;
  }

  bool plantSomethingOnLoad(SeedType seed, int remainingTime)
  {
    if(plant != null)
      return false;

    switch(seed)
    {
      case SeedType.carrot:
      plant = new Carrot();
      chosenPlant=0;
      seedId = 1;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (remainingTime ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: remainingTime));
      plantedSeed = SeedType.carrot;
      plotPlant = 'carrot';
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
      chosenPlant=1;
      seedId = 2;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (remainingTime ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: remainingTime));
      plantedSeed = SeedType.cabbage;
      plotPlant = 'cabbage';
      break;

      case SeedType.kale:
      plant = new Kale();
      chosenPlant=2;
      seedId = 3;
      timeHalfCompleted = new DateTime.now().add(new Duration(seconds: (remainingTime ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(seconds: remainingTime));
      plantedSeed = SeedType.kale;
      plotPlant = 'kale';
      break;
    }

    return true;
  }

  void harvestPlant()
  {
    if(isReadyToPick())
    {
      Inventory.instance().harvestPlant(plantedSeed);

      plant = null;
    }
  }

  bool isPlanted()
  {
    if(plant == null)
      return false;

    return true;
  }

  bool isReadyToPick()
  {
    if(isPlanted())
    {
      if(DateTime.now().isAfter(timeCompleted))
        return true;
    }  

    return false;
  }

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