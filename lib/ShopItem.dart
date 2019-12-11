import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:pocket_farm/GameData.dart';

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

  ShopObject(BuildContext context, {this.theGestureDetector, this.theName, this.price, this.amount, this.maxAmount, this.imageAddress, this.unlocked});

  void addItem() //pass the necessary class here
  {
      //this function would get overridden
      //put logic for adding this item or effect to the player here
      //the amount variable can be used to add in bulk
  }
}

class CarrotSeed extends ShopObject
{
  CarrotSeed(BuildContext context):super(context, 
    theName: FlutterI18n.translate(context, "words.carrotSeeds"),
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/item0.png',
    unlocked:true,
  );

  @override
  void addItem()
  {
    gamedata.carrotSeeds+=amount;
    print("added carrot seed" + amount.toString());
  }
}

class CabbageSeed extends ShopObject
{
   CabbageSeed(BuildContext context):super(context, 
    theName: FlutterI18n.translate(context, "words.cabbageSeeds"),
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/item1.png',
    unlocked:true,
  );

    @override
  void addItem()
  {
    gamedata.cabbageSeeds+=amount;
    print("added carrot seed" + amount.toString());
  }
}

class KaleSeed extends ShopObject
{
   KaleSeed(BuildContext context):super(context, 
    theName: FlutterI18n.translate(context, "words.kaleSeeds"),
    price: 100,
    maxAmount: 100,
    imageAddress: 'assets/images/item2.png',
    amount: 0,
    unlocked:true,
  );

  @override
  void addItem()
  {
    gamedata.kayleSeeds+=amount;
    print("added kale seed" + amount.toString());
  }
}

class MoreHarvest extends ShopObject
{
  MoreHarvest(BuildContext context):super(context, 
    theName: FlutterI18n.translate(context, "words.moreHarvest"),
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade0.png',
    unlocked:true,
  );

  @override
  void addItem()
  {
    gamedata.betterHarvestLevel+=amount;
    print("better harvest" + amount.toString());
  }
}

class MoreMoney extends ShopObject
{
  MoreMoney(BuildContext context):super(context, 
    theName:FlutterI18n.translate(context, "words.moreMoney"),
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade1.png',
    unlocked:true,
  );

  @override
  void addItem()
  {
    gamedata.moreMoneyFromSellingLevel+=amount;
    print("better money" + amount.toString());
  }
}

class MorePlanters extends ShopObject
{
  MorePlanters(BuildContext context):super(context, 
    theName: FlutterI18n.translate(context, "words.morePlanters"),
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade2.png',
    unlocked:true,
  );

  @override
  void addItem()
  {
    gamedata.planterBoxLevel+=amount;
    print("more planter" + amount.toString());
  }
}

class MoreSeeds extends ShopObject
{
  MoreSeeds(BuildContext context):super(context, 
    theName:FlutterI18n.translate(context, "words.moreSeeds"),
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
  FasterGrowth(BuildContext context):super(context, 
    theName: FlutterI18n.translate(context, "words.fasterGrowth"),
    price: 100,
    maxAmount: 100,
    amount: 0,
    imageAddress: 'assets/images/upgrade4.png',
    unlocked:true,
  );

  @override
  void addItem()
  {
    gamedata.fasterGrowingLevel+=amount;
    print("faster growth" + amount.toString());
  }
}
