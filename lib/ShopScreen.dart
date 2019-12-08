import 'package:flutter/material.dart';
import 'Layout.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopScreen createState() => _ShopScreen();
}

class ShopItem
{
  int price = 0;
  int amount = 0;
  GestureDetector theGestureDetector; 
  Text theName;
  ShopItem({this.theGestureDetector, this.theName});
}

class _ShopScreen extends State<ShopScreen> {
  ShopLogic theShop = new ShopLogic();

  @override
  Widget build(BuildContext context) {

  List<Layout> tabOptions = <Layout>[
      Layout(
        title: 'Items',
        icon: Icons.local_florist,
        builder: theShop.buildItemWindow,
      ),
      Layout(
        title: 'Upgrades',
        icon: Icons.grade,
        builder: theShop.buildUpgradeWindow,
      ),
    ];

    return DefaultTabController(
      length: tabOptions.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shop"),
          bottom: buildTabBar(tabOptions),
        ),
        body: buildTabBarView(tabOptions),
        floatingActionButton: FloatingActionButton(
        onPressed: _buy,
        tooltip: 'Buy',
        child: Icon(Icons.shopping_cart),
      ),
      ),
    );
  }

  void _buy() async
  {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Check out"),
          children: [
            Text("This is what you selected, read to buy?"),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, true);
              },
              child: Text("yes"),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: Text("no"),
            ),
          ]
        );
      }
    );
  } 
}

class ShopLogic
{
   List<ShopItem> shopItems = new List<ShopItem>();
   List<ShopItem> shopUpgrades = new List<ShopItem>();
   var itemNames = ['carrot seeds', 'cabbage seeds', 'kale seeds'], 
   upgradeNames = ['more harvest', 'more money', 'more planters', 'more seeds', 'faster growth'];

   //to build the view of the windows
   Widget buildItemWindow() {
    List<Column> columns = new List<Column>();
    for (int i = 0; i < 3; i++) {

      shopItems.add(new ShopItem(
        theGestureDetector: new GestureDetector(
        child: Image.asset(
          'assets/images/item' + i.toString() + '.png',
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => _addToCart(shopItems, i),
        ),
        theName: new Text(itemNames[i]),
      ));

      columns.add(new Column(
        children: [
          shopItems[i].theGestureDetector,
          shopItems[i].theName,
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
      ));
     
    }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
            columns[0],
            columns[1],
            columns[2],
      ],
    );
  }

  Widget buildUpgradeWindow()
  {
    List<Column> columns = new List<Column>();
    for (int i = 0; i < 5; i++) {

      shopUpgrades.add(new ShopItem(
        theGestureDetector: new GestureDetector(
        child: Image.asset(
          'assets/images/upgrade' + i.toString() + '.png',
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => _addToCart(shopUpgrades, i),//() => _seedPicker(),
      ),
     theName: new Text(upgradeNames[i]),
      ));

      columns.add(new Column(
        children: [
          shopUpgrades[i].theGestureDetector,
          shopUpgrades[i].theName,
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
      ));
     
    }
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              columns[0], columns[1],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              columns[2], columns[3],
              ],
            ),
            columns[4],
      ],
    );
  } 

  void _addToCart(List<ShopItem> shopList, int index)
  {
    shopList[index].amount++;
    print(shopList[index].amount.toString() + " " + index.toString());
  }
}



