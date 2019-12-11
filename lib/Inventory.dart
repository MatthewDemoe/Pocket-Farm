
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
  int lifetimeDollars = 100;

  int carrotSeeds = 1;
  int lifetimeCarrotSeeds = 1;
  int cabbageSeeds = 1;
  int lifetimeCabbageSeeds = 1;
  int kaleSeeds = 1;
  int lifetimeKaleSeeds = 1;

  int grownCarrots = 1;
  int lifetimeGrownCarrots = 1;
  int grownCabbages = 1;
  int lifetimeGrownCabbages = 1;
  int grownkale = 1;
  int lifetimeGrownKale = 1;

  void addSeed(SeedType type, int amount)
  {
    switch(type)
    {
      case SeedType.carrot:
      carrotSeeds += amount;
      lifetimeCarrotSeeds += amount;
      break;

      case SeedType.cabbage:
      cabbageSeeds += amount;
      lifetimeCabbageSeeds += amount;
      break;

      case SeedType.kale:
      kaleSeeds += amount;
      lifetimeKaleSeeds += amount;
      break;
    }
  }

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
        grownCarrots++;
        lifetimeGrownCarrots++;
      break;

      case SeedType.cabbage:
        grownCabbages++;
        lifetimeGrownCabbages++;
      break;

      case SeedType.kale:
        grownkale++;
        lifetimeGrownKale++;
      break;
    }
  }
}