abstract class Plant{
  int minutesToGrow;
  int dollarReward;
}

class Carrot extends Plant{
  @override int minutesToGrow = 15;
  @override int dollarReward = 100;
}

class Cabbage extends Plant{
  @override int minutesToGrow = 30;
  @override int dollarReward = 250;
}

class Kale extends Plant{
  @override int minutesToGrow = 45;
  @override int dollarReward = 1000;
}