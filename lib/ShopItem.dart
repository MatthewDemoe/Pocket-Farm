import 'package:flutter/material.dart';

import 'GameData.dart';

//Atiya Nova
//command design pattern used in order to optimize code
abstract class ShopObject
{
  int price = 0;
  int amount = 0, maxAmount;
  GestureDetector theGestureDetector; 
  String theName, imageAddress;
  bool unlocked;

  ShopObject({this.theGestureDetector, this.theName, this.price, this.amount, this.maxAmount, this.imageAddress, this.unlocked});

  void addItem() //pass the necessary class here
  {
      //this function would get overridden
      //put logic for adding this item or effect to the player here
      //the amount variable can be used to add in bulk
  }
}

class CarrotSeed extends ShopObject
{
  CarrotSeed():super(
    theName:"Carrot Seed",
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/item0.png',
    unlocked:true,
  );
}

class CabbageSeed extends ShopObject
{
   CabbageSeed():super(
    theName:"Cabbage Seed",
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/item1.png',
    unlocked:true,
  );
}

class KaleSeed extends ShopObject
{
   KaleSeed():super(
    theName:"Kale Seed",
    price: 100,
    maxAmount: 100,
    imageAddress: 'assets/images/item2.png',
    amount: 0,
    unlocked:true,
  );
}

class MoreHarvest extends ShopObject
{
  MoreHarvest():super(
    theName:"More Harvest",
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade0.png',
    unlocked:true,
  );
}

class MoreMoney extends ShopObject
{
  MoreMoney():super(
    theName:"More Money",
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade1.png',
    unlocked:true,
  );
}

class MorePlanters extends ShopObject
{
  MorePlanters():super(
    theName:"More Planters",
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade2.png',
    unlocked:true,
  );
}

class MoreSeeds extends ShopObject
{
  MoreSeeds():super(
    theName:"More Seeds",
    price: 100,
    maxAmount: 1,
    amount: 0,
    imageAddress: 'assets/images/upgrade3.png',
    unlocked:gamedata.moreSeedsLevel == 2 ? false : true,
  );

  //upgrade function for more seed spawns on the map
  @override
  void addItem() {
    super.addItem();
    if (gamedata.moreSeedsLevel == 0)
      gamedata.moreSeedsLevel = 1; //upgrade to tier 2, cabbages will now spawn
    else if (gamedata.moreSeedsLevel == 1) {
      this.unlocked = false; //lock the seed spawn upgrade as they've hit the max tier
      gamedata.moreSeedsLevel = 2; //upgrade to tier 3, kale will now spawn
    }

    print(this.unlocked);
  }
}

class FasterGrowth extends ShopObject
{
  FasterGrowth():super(
    theName:"Faster Growth",
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade4.png',
    unlocked:true,
  );
}
