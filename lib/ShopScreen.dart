import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'ShopLogic.dart';

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
  ShopLogic theShop;

  @override
  Widget build(BuildContext context) {
  theShop = new ShopLogic(context);
  
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
    ];

    return DefaultTabController(
      length: tabOptions.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(FlutterI18n.translate(context, "words.shop")),
          bottom: buildTabBar(tabOptions),
        ),
        body: 
        //builds the body content
          buildTabBarView(tabOptions),
          floatingActionButton: new FloatingActionButton(
          heroTag: FlutterI18n.translate(context, "words.one"),
          onPressed: _buy,
              tooltip: FlutterI18n.translate(context, "words.buy"),
              child: Icon(Icons.shopping_cart),
        ),
        bottomSheet: new FloatingActionButton(
              heroTag: FlutterI18n.translate(context, "words.two"),
              onPressed: _checkList,
              tooltip: FlutterI18n.translate(context, "words.checkCart"),
              child: Icon(Icons.list),),
      ),
    );
  }

  void _checkList() async
  {
    List<Card> temp = theShop.buildCheckout();

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
              itemCount: temp.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Dismissible(
                  key: Key(temp[index].toString()),
                  onDismissed: (direction)
                  {
                    setState(() {
                    temp.removeAt(index);
                    theShop.removeItem(index); //removes the item from the cart
                  });
                },
                background: Container(color: Colors.red),
                child: temp[index],
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
                theShop.checkOut(); //'checks out' (this is rough)
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
}




