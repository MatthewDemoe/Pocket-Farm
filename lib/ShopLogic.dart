import 'package:flutter/material.dart';
import 'package:badges/badges.dart'; //I was planning on using this for extra visual flair
import 'package:pocket_farm/GameData.dart';
import 'ShopItem.dart';

//Atiya Nova
class ShopLogic 
{
   List<ShopObject> shopItems = new List<ShopObject>();
   List<Column> columns = new List<Column>();
   int itemAmount = 3;

   ShopLogic()
   {
      //the different shop items get added
      shopItems.add(new CarrotSeed());
      shopItems.add(new CabbageSeed());
      shopItems.add(new KaleSeed());
      shopItems.add(new MoreHarvest());
      shopItems.add(new MoreMoney());
      shopItems.add(new MorePlanters());
      shopItems.add(new MoreSeeds());
      shopItems.add(new FasterGrowth());

      //The shop items get initialized
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
        buildHeader(),
        Row(             
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            getShopUI(0),
            getShopUI(1),
            ]),
        getShopUI(2),
      ],
    );
  }

  //builds the window for the upgrades
  Widget buildUpgradeWindow()
  {
     return Column(
     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: <Widget>[
           buildHeader(),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
             getShopUI(itemAmount+0), getShopUI(itemAmount+1),
             ],
           ),
           
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
             getShopUI(itemAmount+3), getShopUI(itemAmount+4),
             ],
           ),
        ],
     );
  } 

  //This builds the ui componenet for each of the shop objects
  Badge getShopUI(int index)
  {
     return Badge(
        badgeContent: Text(shopItems[index].amount.toString()),
        child: columns[index],
      );
  }

  //initializes each shop item
  void initializeShopObject(int i)
  {
    //sets up the gesturedetector and the image
    shopItems[i].theGestureDetector= new GestureDetector(
        child: Image.asset(
          shopItems[i].imageAddress,
          scale: 3.0,
          fit: BoxFit.cover,
        ),
        onTap: () => _addToCart(i)
    );
  }

  //Just increases the amount that's added to the cart
  void _addToCart(int index)
  {
    shopItems[index].amount += 1;
  }

  //This builds the header for all the tabs
  Container buildHeader()
  {
    return Container(
      height:100,
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
        Image.asset('assets/images/shop.png', scale: 2,),
        Text("money " + gamedata.money.toString()),
       ],
      ),
    );
  }

  //Builds what the player sees when they check their cart of items
  List<Card> buildCheckout()
  {
    List<Card> checkoutItems = new List<Card>();
    for (int i = 0; i < shopItems.length; i++)
    {
      if (shopItems[i].amount>0)
      {checkoutItems.add(new Card(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          Text(shopItems[i].theName), 
          Text(shopItems[i].amount.toString()),
          ]),
      ));
      }
    }

    return checkoutItems;
   }

  //The function that adds the cart items to the inventory
  void checkOut()
  {
    for (int i = 0; i < shopItems.length;i++)
    {
      if (shopItems[i].amount>0) shopItems[i].addItem();
    }
  }

  //this is for when the player removes something from their checkout
   void removeItem(int i)
   {
      shopItems[i].amount=0;
   }
}

