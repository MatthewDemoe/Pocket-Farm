//import 'dart:ffi';

//import 'package:flutter/material.dart';
//import 'package:path/path.dart';

import 'dart:async';
import 'package:sqflite/sqflite.dart';

Future<Database> database;

// Define a function that inserts grades into the database
  Future<void> insertFarm(Farm farm) async {
    final Database db = await database;
    await db.insert(
      'farm',
      farm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

/*
  Future<void> updateGrade(Grade grade) async {
  final db = await database;
    await db.update(
      'grades',
      grade.toMap(),
      where: "id = ?",
      whereArgs: [grade.id],
    );
  }
  */

  Future getProjectDetails() async {
    List<Farm> giveme = await farm();
    return giveme;
  }

  // A method that retrieves all the grades from the grades table.
  Future<List<Farm>> farm() async {
    // Get a reference to the database.
    final Database db = await database;

  // Query the table for all The Grades.
    final List<Map<String, dynamic>> maps = await db.query('farm');

    // Convert the List<Map<String, dynamic> into a List<Grade>.
    return List.generate(maps.length, (i) {
      return Farm(
        zero: maps[i]['zero'],
        carrotSeeds: maps[i]['carrotSeeds'],
        cabbageSeeds: maps[i]['cabbageSeeds'],
        kayleSeeds: maps[i]['kayleSeeds'],
        carrots: maps[i]['carrots'],
        cabbage: maps[i]['cabbage'],
        kayle: maps[i]['kayle'],
        carrotsGrown: maps[i]['carrotsGrown'],
        cabbageGrown: maps[i]['cabbageGrown'],
        kayleGrown: maps[i]['kayleGrown'],
        p1Plant: maps[i]['p1Plant'],
        p2Plant: maps[i]['p2Plant'],
        p3Plant: maps[i]['p3Plant'],
        p4Plant: maps[i]['p4Plant'],
        p5Plant: maps[i]['p5Plant'],
        p1TimeLeft: maps[i]['p1TimeLeft'],
        p2TimeLeft: maps[i]['p2TimeLeft'],
        p3TimeLeft: maps[i]['p3TimeLeft'],
        p4TimeLeft: maps[i]['p4TimeLeft'],
        p5TimeLeft: maps[i]['p5TimeLeft'],
        money: maps[i]['money'],
        fasterGrowingLevel: maps[i]['fasterGrowingLevel'],
        betterHarvestLevel: maps[i]['betterHarvestLevel'],
        moreSeedsLevel: maps[i]['moreSeedsLevel'],
        moreMoneyFromSellingLevel: maps[i]['moreMoneyFromSellingLevel'],
        planterBoxLevel: maps[i]['planterBoxLevel'],
        //add more things here as I add them to the class
      );
    });
  }

class Farm {
  int zero;

  int carrotSeeds;
  int cabbageSeeds;
  int kayleSeeds;

  int carrots;
  int cabbage;
  int kayle;

  int carrotsGrown;
  int cabbageGrown;
  int kayleGrown;

  int p1Plant;
  int p2Plant;
  int p3Plant;
  int p4Plant;
  int p5Plant;

  double p1TimeLeft;
  double p2TimeLeft;
  double p3TimeLeft;
  double p4TimeLeft;
  double p5TimeLeft;

  int money;

  int fasterGrowingLevel;
  int betterHarvestLevel;
  int moreSeedsLevel;
  int moreMoneyFromSellingLevel;
  int planterBoxLevel;

  Farm({this.zero, this.carrotSeeds, this.cabbageSeeds, this.kayleSeeds, this.carrots, this.cabbage, this.kayle, this.carrotsGrown, 
    this.cabbageGrown, this.kayleGrown, this.p1Plant, this.p2Plant, this.p3Plant, this.p4Plant, this.p5Plant, this.p1TimeLeft, this.p2TimeLeft, 
    this.p3TimeLeft, this.p4TimeLeft, this.p5TimeLeft, this.money, this.fasterGrowingLevel, this.betterHarvestLevel, this.moreSeedsLevel, 
    this.moreMoneyFromSellingLevel, this.planterBoxLevel});

  Map<String, dynamic> toMap() {
    return {
      'zero': zero,
      'carrotSeeds': carrotSeeds,
      'cabbageSeeds': cabbageSeeds,
      'kayleSeeds': kayleSeeds,
      'carrots': carrots,
      'cabbage': cabbage,
      'kayle': kayle,
      'carrotsGrown': carrotsGrown,
      'cabbageGrown': cabbageGrown,
      'kayleGrown': kayleGrown,
      'p1Plant': p1Plant,
      'p2Plant': p2Plant,
      'p3Plant': p3Plant,
      'p4Plant': p4Plant,
      'p5Plant': p5Plant,
      'p1TimeLeft': p1TimeLeft,
      'p2TimeLeft': p2TimeLeft,
      'p3TimeLeft': p3TimeLeft,
      'p4TimeLeft': p4TimeLeft,
      'p5TimeLeft': p5TimeLeft,
      'money': money,
      'fasterGrowingLevel': fasterGrowingLevel,
      'betterHarvestLevel': betterHarvestLevel,
      'moreSeedsLevel': moreSeedsLevel,
      'moreMoneyFromSellingLevel': moreMoneyFromSellingLevel,
      'planterBoxLevel': planterBoxLevel,
    };
  }

    @override
  String toString() {
    return 'Farm{zero: $zero, carrotSeeds: $carrotSeeds, cabbageSeeds: $cabbageSeeds, kayleSeeds: $kayleSeeds, carrots: $carrots, cabbage: $cabbage,'+
    ' kayle: $kayle, carrotsGrown: $carrotsGrown, cabbageGrown: $cabbageGrown, kayleGrown: $kayleGrown, p1Plant: $p1Plant, p2Plant: $p2Plant, p3Plant: $p3Plant, p4Plant: $p4Plant,'+
    ' p5Plant: $p5Plant, p1TimeLeft: $p1TimeLeft, p2TimeLeft: $p2TimeLeft, p3TimeLeft: $p3TimeLeft, p4TimeLeft: $p4TimeLeft, p5TimeLeft: $p5TimeLeft, money: $money,' +
    ' fasterGrowingLevel: $fasterGrowingLevel, betterHarvestLevel: $betterHarvestLevel, moreSeedsLevel: $moreSeedsLevel, moreMoneyFromSellingLevel: $moreMoneyFromSellingLevel, planterBoxLevel: $planterBoxLevel }';
  }
}