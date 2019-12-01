import 'package:pocket_farm/Enums.dart';

import 'Plants.dart';
class FarmPlot{
  Plant plant;
  DateTime timeCompleted; 

  bool plantSomething(SeedType seed)
  {
    if(plant != null)
      return false;

    switch(seed)
    {
      case SeedType.carrot:
      plant = new Carrot();
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.cabbage:
      plant = new Cabbage();
      timeCompleted = new DateTime.now().add(new Duration(minutes: plant.minutesToGrow));
      break;

      case SeedType.kale:
      plant = new Kale();
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
}