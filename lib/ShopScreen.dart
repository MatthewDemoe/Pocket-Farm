import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'ShopLogic.dart';
import 'GameData.dart';

//Atiya Nova
//Using parts of a layout example shown in class

class Layout {
  final String title;
  final IconData icon;
  final Function builder;

  const Layout({this.title, this.icon, this.builder});
}

//builds the tab views
Widget buildTabBar(List<Layout> options) {
  return TabBar(
    isScrollable: true,
    tabs: options.map<Widget>((Layout option) {
      return Tab(
        text: option.title,
        icon: Icon(option.icon),
      );
    }).toList(),
  );
}

Widget buildTabBarView(List<Layout> options) {
  return TabBarView(
    children: 
    options.map<Widget>((Layout option) {
      return Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          child: option.builder(),
        ),
      );
    }).toList(),
  );  
}

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopScreen createState() => _ShopScreen();
}

class _ShopScreen extends State<ShopScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  ShopLogic theShop;
  List<Card> theCart;
  List<int> itemsToSell = [0,0,0,0,0,0];

  @override
  Widget build(BuildContext context) {
  theShop = new ShopLogic(context);
  theShop.contextKey = _scaffoldKey; //set the shops scaffold key
  //Sets up the tab options
  List<Layout> tabOptions = <Layout>[
      Layout(
        title: FlutterI18n.translate(context, "words.items"),
        icon: Icons.local_florist,
        builder: theShop.buildItemWindow,
      ),
      Layout(
        title: FlutterI18n.translate(context, "words.upgrades"),
        icon: Icons.grade,
        builder: theShop.buildUpgradeWindow,
      ),
      Layout(
        title: 'Sell',
        icon: Icons.attach_money,
        builder: buildSellingWindow,
      ),
    ];

    return DefaultTabController(
      length: tabOptions.length,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, "words.shop")),
          bottom: buildTabBar(tabOptions),
        ),
        body: 
        //builds the body content
          buildTabBarView(tabOptions),
        bottomSheet: new 
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
              FloatingActionButton(
              heroTag: FlutterI18n.translate(context, "words.two"),
              onPressed: _checkList,
              tooltip: FlutterI18n.translate(context, "words.checkCart"),
              child: Icon(Icons.shopping_basket),),
              FloatingActionButton(
              heroTag: "one",
                onPressed: _buy,
              tooltip: 'buy',
              child: Icon(Icons.shopping_cart),),
        ],),
           
      ),
    );
  }

  void _checkList() async
  {
    theCart = theShop.buildCheckout();

    //the list of cart items are build here with a listview.builder
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(FlutterI18n.translate(context, "words.checkItems")),
          children: [
            Container(
            height: 300.0, // Change as per your requirement
            width: 300.0,
            child: new ListView.builder
            (
              //built the dismissable with an example from the flutter docs
              itemCount: theCart.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Dismissible(
                  key: Key(theCart[index].toString()),
                  onDismissed: (direction)
                  {
                    setState(() {
                    theCart.removeAt(index);
                    theShop.removeItem(index); //removes the item from the cart
                  });
                },
                background: Container(color: Colors.red),
                child: theCart[index],
              );
            }
            ),
            ),
          ]
        );
      }
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
          title: Text(FlutterI18n.translate(context, "words.checkOut")),
          children: [
            Text(FlutterI18n.translate(context, "words.readyToBuy")),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, true);
                theShop.checkOut();
                theCart.clear(); //'checks out' (this is rough)
              },
              child: Text(FlutterI18n.translate(context, "words.yes")),
            ),
            SimpleDialogOption(
              onPressed: (){
                Navigator.pop(context, false);
              },
              child: Text(FlutterI18n.translate(context, "words.no")),
            ),
          ]
        );
      }
    );
  } 

   //builds the window for selling
  Widget buildSellingWindow()
  {
    List<Row> display = new List<Row>();
    //making a list of the shop items
    List<int> temp = gamedata.getShopList();
    //the item names
    var names = ["Carrot Seeds", "Cabbage Seeds", "Kale Seeds", "Carrot", "Cabbage", "Kale"];

    for (int i = 0; i < temp.length; i++)
        display.add(
          new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(names[i]),
            Text(itemsToSell[i].toString()),
              GestureDetector(
                child:Container(
                  width: 30.0,
                  margin: EdgeInsets.all(4.0),
                  color: Colors.white,
                  child: Icon(Icons.arrow_upward),
                ),
                onTap: (){
                  setState(() {
                    if (temp[i]>0)
                    itemsToSell[i]++;
                    print(itemsToSell);
                  });
                },
            ),
          GestureDetector(
              child:Container(
                width: 30.0,
                margin: EdgeInsets.all(4.0),
                color: Colors.white,
                child: Icon(Icons.arrow_downward),
              ),
              onTap: (){
                setState(() {
                  if (itemsToSell[i]>0)
                  itemsToSell[i]--;
                  print(itemsToSell);
                });
              },
          ),
          ],
        ));

    return 
    Column(children: <Widget>[
      theShop.buildHeader(),
      Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: display
          .map((row) => Container(
                child: row,
                padding: EdgeInsets.all(5.0),
              ))
          .toList()),
      GestureDetector(
        child:FloatingActionButton(
        child: Icon(Icons.done_outline),
        onPressed: (){
          setState(() {
            theShop.sell(itemsToSell);
          });
          },
      ),
      ),
  ],);

  }
    
} 





