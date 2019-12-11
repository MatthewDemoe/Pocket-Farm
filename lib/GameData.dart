
GameData gamedata;

class GameData {
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
        this. fasterGrowingLevel = map['fasterGrowingLevel'];
        this.betterHarvestLevel = map['betterHarvestLevel'];
        this.moreSeedsLevel = map['moreSeedsLevel'];
        this.moreMoneyFromSellingLevel = map['moreMoneyFromSellingLevel'];
        this.planterBoxLevel = map['planterBoxLevel'];
      }
}