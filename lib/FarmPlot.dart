import 'package:flutter/cupertino.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'Enums.dart';
import 'package:flutter/material.dart';


import 'Plants.dart';
class FarmPlot{
  Plant plant;
  DateTime timeHalfCompleted;
  DateTime timeCompleted; 

  GestureDetector gestureDetector;
  FAProgressBar theProgress;

  FarmPlot({this.gestureDetector, this.theProgress});

  bool plantSomething(SeedType seed)
  {
    if(plant != null)
      return false;

    switch(seed)
    {
      case SeedType.carrot:
      plant = new Carrot();
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.kale:
      plant = new Kale();
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
}