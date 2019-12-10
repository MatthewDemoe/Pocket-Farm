
import 'package:pocket_farm/Enums.dart';

class Inventory{

  static Inventory _inventory; 

  static Inventory instance()
  {    
    if(_inventory == null)      {
      _inventory = new Inventory();
    }

    return _inventory;    
  }

  int dollars = 100;

  int carrotSeeds = 0;
  int cabbageSeeds = 0;
  int kaleSeeds = 0;

  int grownCarrots = 1;
  int grownCabbages = 1;
  int grownkale = 1;

  bool plantSeed(SeedType type)
  {
    switch(type)
    {
      case SeedType.carrot:
      if(carrotSeeds > 0)
      {
        carrotSeeds--;
        return true;
      }
      break;

      case SeedType.cabbage:
      if(cabbageSeeds > 0)
      {
        cabbageSeeds--;
        return true;
      }
      break;

      case SeedType.kale:
      if(kaleSeeds > 0)
      {
        kaleSeeds--;
        return true;
      }

      break;
    }

    return false;
  }

  void harvestPlant(SeedType type)
  {
    switch(type)
    {
      case SeedType.carrot:
        carrotSeeds++;
      break;

      case SeedType.cabbage:
        cabbageSeeds++;
      break;

      case SeedType.kale:
        kaleSeeds++;
      break;
    }
  }
}