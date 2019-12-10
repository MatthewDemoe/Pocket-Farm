import 'package:flutter/material.dart';
import 'package:pocket_farm/Plants.dart';
import 'ShopItem.dart';

class ShopLogic
{
   List<ShopObject> shopItems = new List<ShopObject>();
   List<Column> columns = new List<Column>();
   int itemAmount = 3;

   ShopLogic()
   {
      //adding all the different shop items
      shopItems.add(new CarrotSeed());
      shopItems.add(new CabbageSeed());
      shopItems.add(new KaleSeed());
      shopItems.add(new MoreHarvest());
      shopItems.add(new MoreMoney());
      shopItems.add(new MorePlanters());
      shopItems.add(new MoreSeeds());
      shopItems.add(new FasterGrowth());

      for (int i = 0; i < shopItems.length; i++) {
      initializeShopObject(i);
      columns.add(new Column(
        children: [
          shopItems[i].theGestureDetector,
          new Text(shopItems[i].theName),
          new Text(shopItems[i].price.toString()),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
      ));
    }
    }

   //to build the view of the windows
   Widget buildItemWindow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
            columns[0],
            columns[1],
            columns[2],
      ],
    );
  }

  //builds the window for the upgrades
  Widget buildUpgradeWindow()
  {
     return Column(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: <Widget>[
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
             columns[itemAmount+0], columns[itemAmount+1],
             ],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
             columns[itemAmount+2], columns[itemAmount+3],
             ],
           ),
           columns[itemAmount+4],
     ],
     );
  } 

  //sets up the gesture detector for each item
  void initializeShopObject(int i)
  {
    shopItems[i].theGestureDetector= new GestureDetector(
        child: Image.asset(
          shopItems[i].imageAddress,
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => _addToCart(i)
    );
  }

  void _checkOut()
  {
    for (int i = 0; i < shopItems.length;i++)
    {
      shopItems[i].AddItem();
    }
  }

  void _addToCart(int index)
  {
    shopItems[index].amount += 1;
    print(shopItems[index].amount.toString() + " " + index.toString());
  }

  List<Card> buildCheckout()
  {
    List<Card> checkoutItems = new List<Card>();
    for (int i = 0; i < shopItems.length; i++)
    {
      if (shopItems[i].amount>0)
      {checkoutItems.add(new Card(
        child:Row(children: <Widget>[
          Text(shopItems[i].theName), 
          Text(shopItems[i].amount.toString()),
          ]),
      ));
      }
    }

    return checkoutItems;
   }
  }

