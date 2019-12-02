<<<<<<< Updated upstream
import 'package:pocket_farm/Enums.dart';
=======
import 'package:flutter/cupertino.dart';
import 'Enums.dart';
>>>>>>> Stashed changes

import 'Plants.dart';
class FarmPlot{
  Plant plant;
<<<<<<< Updated upstream
  DateTime timeCompleted; 

=======
  DateTime timeHalfCompleted;
  DateTime timeCompleted; 

  GestureDetector gestureDetector;

  FarmPlot({this.gestureDetector});

>>>>>>> Stashed changes
  bool plantSomething(SeedType seed)
  {
    if(plant != null)
      return false;

    switch(seed)
    {
      case SeedType.carrot:
      plant = new Carrot();
<<<<<<< Updated upstream
=======
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
>>>>>>> Stashed changes
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
<<<<<<< Updated upstream
=======
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
>>>>>>> Stashed changes
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.kale:
      plant = new Kale();
<<<<<<< Updated upstream
=======
      timeHalfCompleted = new DateTime.now().add(new Duration(minutes: (plant.minutesToGrow ~/ 2)));
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
    }
=======
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
>>>>>>> Stashed changes

    return false;
  }
}