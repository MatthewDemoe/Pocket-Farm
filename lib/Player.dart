import 'Enums.dart';
import 'Inventory.dart';

//player class to show player (now inventory is used)
class Player{

  void plantSeed(SeedType seed)
  {
    Inventory.instance().plantSeed(seed);
    /*switch(seed)
    {
      case SeedType.carrot:
      if(Inventory.instance().carrotSeeds > 0)
      {
        inventory.carrotSeeds--;
        return true;
      }

      return false;
      break;

      case SeedType.cabbage:
      if(inventory.cabbageSeeds > 0)
      {
        inventory.cabbageSeeds--;
        return true;
      }

      return false;
      break;

      case SeedType.kale:
      if(inventory.kaleSeeds > 0)
      {
        inventory.kaleSeeds--;
        return true;
      }

      return false;
      break;

      default : 
      return false;
    }*/
  }
}