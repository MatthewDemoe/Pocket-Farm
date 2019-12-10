import 'package:flutter/cupertino.dart';
import 'package:pocket_farm/Inventory.dart';
import 'Enums.dart';

import 'Plants.dart';
class FarmPlot{
  Plant plant;
  DateTime timeHalfCompleted;
  DateTime timeCompleted; 

  GestureDetector gestureDetector;

  FarmPlot({this.gestureDetector});

  SeedType plantedSeed;

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
      plantedSeed = SeedType.carrot;
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      plantedSeed = SeedType.cabbage;
      break;

      case SeedType.kale:
      plant = new Kale();
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      plantedSeed = SeedType.kale;
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