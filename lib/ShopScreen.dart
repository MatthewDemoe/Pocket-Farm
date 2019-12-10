import 'package:flutter/material.dart';
import 'ShopLogic.dart';

//Atiya Nova
//Using parts of a layout example shown in class

class Layout {
  final String title;
  final IconData icon;
  final Function builder;

  const Layout({this.title, this.icon, this.builder});
}

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
    children: options.map<Widget>((Layout option) {
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
        body: 
          buildTabBarView(tabOptions),
        floatingActionButton: new FloatingActionButton(
          onPressed: _checkList,
          tooltip: 'check cart',
          child: Icon(Icons.list),
        ),
        
      ),
    );
  }


   void _checkList() async
  {
    List<Card> temp = theShop.buildCheckout();

    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text("Check your items"),
          children: [
            Container(
            height: 300.0, // Change as per your requirement
            width: 300.0,
            child: new ListView.builder
            (
              itemCount: temp.length,
            itemBuilder: (BuildContext ctxt, int index) {
            return temp[index];
            }),),
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




