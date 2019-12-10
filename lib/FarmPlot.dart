import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'Enums.dart';
import 'package:flutter/material.dart';
import 'dart:async';


import 'Plants.dart';
class FarmPlot{
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
  //set up the timer stuff
  //you set off the timer stuff in the switch statement

  FarmPlot({this.gestureDetector, this.theProgress, this.signpostImage});

  bool plantSomething(SeedType seed)
  {
    if(plant != null)
      return false;

    switch(seed)
    {
      case SeedType.carrot:
      setProgressBar();
      plant = new Carrot();
      chosenPlant=0;
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.cabbage:
      setProgressBar();
      plant = new Cabbage();
      chosenPlant=1;
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.kale:
      setProgressBar();
      plant = new Kale();
      chosenPlant=2;
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;
    }

    return true;
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

  void setProgressBar()
  {
    theProgress = new FAProgressBar(
        size: 8,
        currentValue: 10, 
        maxValue: 10, 
        borderRadius: 1,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.down,
        animatedDuration: const Duration(minutes: 1),
        changeColorValue: 5,
        backgroundColor: Colors.white,
        progressColor: Colors.red,
        changeProgressColor: Colors.blue,
      );
  }
  
}