import 'package:flutter/material.dart';
import 'package:badges/badges.dart'; //I was planning on using this for extra visual flair
import 'package:path/path.dart';
import 'package:pocket_farm/GameData.dart';
import 'Inventory.dart';
import 'ShopItem.dart';

//upgrade snackbar
final upgradesSnackBar = new SnackBar(
  behavior: SnackBarBehavior.floating,
  content: Text('You have maxed this upgrade.\nThere is no need to buy any more.'),
  action: SnackBarAction(
    label: 'Okay!',
    onPressed: () {},
  ),
);

//full cart snackbar
final fullcartSnackBar = new SnackBar(
  behavior: SnackBarBehavior.floating,
  content: Text('You have the max amount of this item already in your cart!'),
  action: SnackBarAction(
    label: 'Okay!',
    onPressed: () {},
  ),
);

//Atiya Nova
class ShopLogic 
{
   List<ShopObject> shopItems = new List<ShopObject>();
   List<Column> columns = new List<Column>();
   int itemAmount = 3;
   GlobalKey<ScaffoldState> contextKey; //scaffold key to show snackbars

   ShopLogic(BuildContext context)
   {
      //the different shop items get added
      shopItems.add(new CarrotSeed(context));
      shopItems.add(new CabbageSeed(context));
      shopItems.add(new KaleSeed(context));
      shopItems.add(new MoreHarvest(context));
      shopItems.add(new MoreMoney(context));
      shopItems.add(new MorePlanters(context));
      shopItems.add(new MoreSeeds(context));
      shopItems.add(new FasterGrowth(context));

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
        onTap: () => _addToCart(i),
        
    );
  }

  //Just increases the amount that's added to the cart
  void _addToCart(int index)
  {
    if (shopItems[index].unlocked && shopItems[index].amount < shopItems[index].maxAmount) //only add to cart if item is unlocked and under max amount you can buy
      shopItems[index].amount += 1;
    else if (shopItems[index].unlocked == false)
      contextKey.currentState.showSnackBar(upgradesSnackBar); //let the player know they've maxed the upgrade
    else if (shopItems[index].amount >= shopItems[index].maxAmount && shopItems[index].unlocked)
      contextKey.currentState.showSnackBar(fullcartSnackBar); //let the player know they can't add any more items to the cart
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
        Text("Dollars " + Inventory.instance().dollars.toString()),
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
  bool checkOut()
  {
    int totalCost = 0;

    for (int i = 0; i < shopItems.length;i++)
    {
      //increment total cost
      if (shopItems[i].amount > 0) {
        totalCost += shopItems[i].price * shopItems[i].amount;
      }

    }

    if(totalCost > Inventory.instance().dollars)
    {
       return false;
    }

    else
    {
      for (int i = 0; i < shopItems.length;i++)
      {
        //only buy an item if it's in the cart
        if (shopItems[i].amount > 0) {
          shopItems[i].addItem();
          shopItems[i].amount = 0;
        }
      }

      Inventory.instance().dollars -= totalCost;
      Inventory.instance().updateGameData();
      return true;
    }
  }

  //this is for when the player removes something from their checkout
   void removeItem(int i)
   {
      shopItems[i].amount=0;
   }

    //function used to sell the items
   void sell(List<int> items)
   {
     for (int i = 0; i < items.length; i++)
     {
       gamedata.sellItem(i, items[i]);
       Inventory.instance().dollars+=(100*items[i]);
     }
   }
}

