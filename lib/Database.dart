import 'dart:async';
import 'GameData.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> database;

// Define a function that inserts grades into the database
Future<void> saveData() async {
  final Database db = await database;

    await db.insert(
      'farm',
      gamedata.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
}

void checkEmpty() async
{
  final Database db = await database;
  
  final List<Map<String, dynamic>> maps = await db.query('farm');

  if (maps.length < 1)
  {
    gamedata = new GameData(
    zero: 0,
    carrotSeeds: 0,
    cabbageSeeds: 0,
    kayleSeeds: 0,
    carrots: 0,
    cabbage: 0,
    kayle: 0,
    carrotsGrown: 0,
    cabbageGrown: 0,
    kayleGrown: 0,
    p1Plant: 0,
    p2Plant: 0,
    p3Plant: 0,
    p4Plant: 0,
    p5Plant: 0,
    p1TimeLeft: 0,
    p2TimeLeft: 0,
    p3TimeLeft: 0,
    p4TimeLeft: 0,
    p5TimeLeft: 0,
    money: 0,
    fasterGrowingLevel: 0,
    betterHarvestLevel: 0,
    moreSeedsLevel: 0,
    moreMoneyFromSellingLevel: 0,
    planterBoxLevel: 0,
    );
    saveData();
  }
}

void loadData() async {
  gamedata = await loadfunc();
  print(gamedata.toMap());
}

// A method that retrieves all the farms from the farms table.
Future<GameData> loadfunc() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for the list of farms, even though there's only 1.
  final List<Map<String, dynamic>> maps = await db.query('farm');
  
  /*gamedata = await db.query(
    'farm',
    where: "zero = ?",
    whereArgs: [gamedata.zero],
  );*/
  
  // Convert the List<Map<String, dynamic> into a List<GameData>.
  //return List.generate(maps.length, (i) {
  return GameData(
    zero: maps[0]['zero'],
    carrotSeeds: maps[0]['carrotSeeds'],
    cabbageSeeds: maps[0]['cabbageSeeds'],
    kayleSeeds: maps[0]['kayleSeeds'],
    carrots: maps[0]['carrots'],
    cabbage: maps[0]['cabbage'],
    kayle: maps[0]['kayle'],
    carrotsGrown: maps[0]['carrotsGrown'],
    cabbageGrown: maps[0]['cabbageGrown'],
    kayleGrown: maps[0]['kayleGrown'],
    p1Plant: maps[0]['p1Plant'],
    p2Plant: maps[0]['p2Plant'],
    p3Plant: maps[0]['p3Plant'],
    p4Plant: maps[0]['p4Plant'],
    p5Plant: maps[0]['p5Plant'],
    p1TimeLeft: maps[0]['p1TimeLeft'],
    p2TimeLeft: maps[0]['p2TimeLeft'],
    p3TimeLeft: maps[0]['p3TimeLeft'],
    p4TimeLeft: maps[0]['p4TimeLeft'],
    p5TimeLeft: maps[0]['p5TimeLeft'],
    money: maps[0]['money'],
    fasterGrowingLevel: maps[0]['fasterGrowingLevel'],
    betterHarvestLevel: maps[0]['betterHarvestLevel'],
    moreSeedsLevel: maps[0]['moreSeedsLevel'],
    moreMoneyFromSellingLevel: maps[0]['moreMoneyFromSellingLevel'],
    planterBoxLevel: maps[0]['planterBoxLevel'],
  );
  //});
}
