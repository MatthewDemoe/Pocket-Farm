import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_farm/GameData.dart';

import 'dart:async';
import 'Inventory.dart';
import 'package:pocket_farm/Inventory.dart';

//save data to the cloud
Future<void> saveDataCloud(GameData data) async {
  Inventory.instance().updateGameData();
  print(gamedata.toMap());

  Firestore.instance.collection('userData').document('testing').setData({
        'zero': data.zero,
        'carrotSeeds': data.carrotSeeds,
        'cabbageSeeds': data.cabbageSeeds,
        'kayleSeeds': data.kayleSeeds,
        'carrots': data.carrots,
        'cabbage': data.cabbage,
        'kayle': data.kayle,
        'carrotsGrown': data.carrotsGrown,
        'cabbageGrown': data.cabbageGrown,
        'kayleGrown': data.kayleGrown,
        'p1Plant': data.p1Plant,
        'p2Plant': data.p2Plant,
        'p3Plant': data.p3Plant,
        'p4Plant': data.p4Plant,
        'p5Plant': data.p5Plant,
        'p1TimeLeft': data.p1TimeLeft,
        'p2TimeLeft': data.p2TimeLeft,
        'p3TimeLeft': data.p3TimeLeft,
        'p4TimeLeft': data.p4TimeLeft,
        'p5TimeLeft': data.p5TimeLeft,
        'money': data.money,
        'fasterGrowingLevel': data.fasterGrowingLevel,
        'betterHarvestLevel': data.betterHarvestLevel,
        'moreSeedsLevel': data.moreSeedsLevel,
        'moreMoneyFromSellingLevel': data.moreMoneyFromSellingLevel,
        'planterBoxLevel': data.planterBoxLevel,
  });
}

//load data from the cloud
void cloudLoad() async
{
  var d = await Firestore.instance.collection('userData').document('testing').get();

    gamedata = new GameData(
    zero: d.data['zero'],
    carrotSeeds: d.data['carrotSeeds'],
    cabbageSeeds: d.data['cabbageSeeds'],
    kayleSeeds: d.data['kayleSeeds'],
    carrots: d.data['carrots'],
    cabbage: d.data['cabbage'],
    kayle: d.data['kayle'],
    carrotsGrown: d.data['carrotsGrown'],
    cabbageGrown: d.data['cabbageGrown'],
    kayleGrown: d.data['kayleGrown'],
    p1Plant: d.data['p1Plant'],
    p2Plant: d.data['p2Plant'],
    p3Plant: d.data['p3Plant'],
    p4Plant: d.data['p4Plant'],
    p5Plant: d.data['p5Plant'],
    p1TimeLeft: d.data['p1TimeLeft'].toInt(),
    p2TimeLeft: d.data['p2TimeLeft'].toInt(),
    p3TimeLeft: d.data['p3TimeLeft'].toInt(),
    p4TimeLeft: d.data['p4TimeLeft'].toInt(),
    p5TimeLeft: d.data['p5TimeLeft'].toInt(),
    money: d.data['money'],
    fasterGrowingLevel: d.data['fasterGrowingLevel'],
    betterHarvestLevel: d.data['betterHarvestLevel'],
    moreSeedsLevel: d.data['moreSeedsLevel'],
    moreMoneyFromSellingLevel: d.data['moreMoneyFromSellingLevel'],
    planterBoxLevel: d.data['planterBoxLevel'],
  );

  Inventory.instance().carrotSeeds = gamedata.carrotSeeds;
  Inventory.instance().cabbageSeeds = gamedata.cabbageSeeds;
  Inventory.instance().kaleSeeds = gamedata.kayleSeeds;
  Inventory.instance().grownCarrots = gamedata.carrots;
  Inventory.instance().grownCabbages = gamedata.cabbage;
  Inventory.instance().grownkale = gamedata.kayle;
  Inventory.instance().lifetimeGrownCarrots = gamedata.carrotsGrown;
  Inventory.instance().lifetimeGrownCabbages = gamedata.cabbageGrown;
  Inventory.instance().lifetimeGrownKale = gamedata.kayleGrown;
  Inventory.instance().dollars = gamedata.money;

  print(gamedata.toMap());
}