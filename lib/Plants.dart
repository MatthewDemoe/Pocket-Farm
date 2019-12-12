import 'GameData.dart';

abstract class Plant{
  int secondsToGrow;
  int dollarReward;
}

class Carrot extends Plant{
  @override int secondsToGrow = 120 ~/ gamedata.fasterGrowingLevel;
  @override int dollarReward = 100 * gamedata.moreMoneyFromSellingLevel;
}

class Cabbage extends Plant{
  @override int secondsToGrow = 240 ~/ gamedata.fasterGrowingLevel;
  @override int dollarReward = 250 * gamedata.moreMoneyFromSellingLevel;
}

class Kale extends Plant{
  @override int secondsToGrow = 360 ~/ gamedata.fasterGrowingLevel;
  @override int dollarReward = 1000 * gamedata.moreMoneyFromSellingLevel;
}