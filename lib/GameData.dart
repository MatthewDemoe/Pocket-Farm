import 'package:pocket_farm/ShopItem.dart';

GameData gamedata = new GameData();


class GameData {

  //variables used to store player data
  int zero = 0;

  int carrotSeeds = 1;
  int cabbageSeeds = 1;
  int kayleSeeds = 1;

  int carrots = 0;
  int cabbage = 0;
  int kayle = 0;
  
  int carrotsGrown = 0;
  int cabbageGrown = 0;
  int kayleGrown = 0;

  int p1Plant = 0;
  int p2Plant = 0;
  int p3Plant = 0;
  int p4Plant = 0;
  int p5Plant = 0;

  int p1TimeLeft = 0;
  int p2TimeLeft = 0;
  int p3TimeLeft = 0;
  int p4TimeLeft = 0;
  int p5TimeLeft = 0;

  int money = 50;

  int fasterGrowingLevel = 1;
  int betterHarvestLevel = 1;
  int moreSeedsLevel = 0;
  int moreMoneyFromSellingLevel = 1;
  int planterBoxLevel = 0;

  GameData({
      this.zero,
      this.carrotSeeds,
      this.cabbageSeeds,
      this.kayleSeeds,
      this.carrots,
      this.cabbage,
      this.kayle,
      this.carrotsGrown,
      this.cabbageGrown,
      this.kayleGrown,
      this.p1Plant,
      this.p2Plant,
      this.p3Plant,
      this.p4Plant,
      this.p5Plant,
      this.p1TimeLeft,
      this.p2TimeLeft,
      this.p3TimeLeft,
      this.p4TimeLeft,
      this.p5TimeLeft,
      this.money,
      this.fasterGrowingLevel,
      this.betterHarvestLevel,
      this.moreSeedsLevel,
      this.moreMoneyFromSellingLevel,
      this.planterBoxLevel,
      });

      //function to use to sell items in the shop
      void sellItem(int index, int amount)
      {
        switch (index)
        {
          case 0: {carrotSeeds-=amount; } break;
          case 1: {cabbageSeeds-=amount;} break; 
          case 2: {kayleSeeds-=amount; } break; 
          case 3: {carrots-=amount; }break;
          case 4: {cabbage-=amount; } break; 
          case 5: {kayle-=amount; } break; 
        }
      }

      //function to help construct the list of the shopclass (for selling)
      List<int> getShopList()
      {
          List<int> temp = new List<int>();
          temp.add(carrotSeeds);
          temp.add(cabbageSeeds);
          temp.add(kayleSeeds);
          temp.add(carrots);
          temp.add(cabbage);
          temp.add(kayle);
          return temp;
      }

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

      GameData.fromMap(Map<String, dynamic> map) {
        this.zero = map['zero'];
        this.carrotSeeds = map['carrotSeeds'];
        this.cabbageSeeds = map['cabbageSeeds'];
        this.kayleSeeds = map['kayleSeeds'];
        this.carrots = map['carrots'];
        this.cabbage = map['cabbage'];
        this.kayle = map['kayle'];
        this.carrotsGrown = map['carrotsGrown'];
        this.cabbageGrown = map['cabbageGrown'];
        this.kayleGrown = map['kayleGrown'];
        this.p1Plant = map['p1Plant'];
        this.p2Plant = map['p2Plant'];
        this.p3Plant = map['p3Plant'];
        this.p4Plant = map['p4Plant'];
        this.p5Plant = map['p5Plant'];
        this.p1TimeLeft = map['p1TimeLeft'];
        this.p2TimeLeft = map['p2TimeLeft'];
        this.p3TimeLeft = map['p3TimeLeft'];
        this.p4TimeLeft = map['p4TimeLeft'];
        this.p5TimeLeft = map['p5TimeLeft'];
        this.money = map['money'];
        this. fasterGrowingLevel = map['fasterGrowingLevel'];
        this.betterHarvestLevel = map['betterHarvestLevel'];
        this.moreSeedsLevel = map['moreSeedsLevel'];
        this.moreMoneyFromSellingLevel = map['moreMoneyFromSellingLevel'];
        this.planterBoxLevel = map['planterBoxLevel'];
      }
}
