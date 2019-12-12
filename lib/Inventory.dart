
import 'package:pocket_farm/Enums.dart';
import 'GameData.dart';

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

  int carrotSeeds = 1;
  int lifetimeCarrotSeeds = 1;
  int cabbageSeeds = 1;
  int lifetimeCabbageSeeds = 1;
  int kaleSeeds = 1;
  int lifetimeKaleSeeds = 1;

  int grownCarrots = 0;
  int lifetimeGrownCarrots = 0;
  int grownCabbages = 0;
  int lifetimeGrownCabbages = 0;
  int grownkale = 0;
  int lifetimeGrownKale = 0;

  void addSeed(SeedType type, int amount)
  {
    //picks which seed to add
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

  //plants the seed of a specific type
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

  void updateGameData()
  { 
        //updates the storage data
        gamedata.carrotSeeds = carrotSeeds;
        gamedata.cabbageSeeds = cabbageSeeds;
        gamedata.kayleSeeds = kaleSeeds;
        gamedata.carrots = grownCarrots;
        gamedata.cabbage = grownCabbages;
        gamedata.kayle = grownkale;
        gamedata.carrotsGrown = lifetimeGrownCarrots;
        gamedata.cabbageGrown = lifetimeGrownCabbages;
        gamedata.kayleGrown = lifetimeGrownKale;
        gamedata.money = dollars;
  }

  
}