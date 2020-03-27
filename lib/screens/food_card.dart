import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../styles/styles.dart';

class FoodCard extends StatefulWidget {
  // FoodCard(this.food);
   final String name;
   final double price;
   final String image;

   FoodCard(this.name, this.price, this.image);
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> with SingleTickerProviderStateMixin {
  String get name => widget.name;
  double get price => widget.price;
  String get image => widget.image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return new StoreConnector<AppState, _ViewModel>(
    converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
           return Container(
      child: Card(
        // shape: roundedRectangle12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildImage(),
            buildTitle(),
            buildRating(),
            buildPriceInfo(vm),
          ],
        ),
      ),
    );
        });
  }

  Widget buildImage() {
    return Flexible(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: new NetworkImage(
                'https://img.icons8.com/metro/50/000000/food.png',
              ),
              )
          ),

        )
   
    );
  }

  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        this.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: titleStyle,
      ),
    );
  }

  Widget buildRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingBar( 
            initialRating: 5.0,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 14,
            unratedColor: Colors.black,
            itemPadding: EdgeInsets.only(right: 4.0),
            ignoreGestures: true,
            itemBuilder: (context, index) => Icon(Icons.star),
            onRatingUpdate: (rating) {},
          ),
          Text('5.0'),
        ],
      ),
    );
  }

  Widget buildPriceInfo(_ViewModel vm) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            price.toString(),
            style: titleStyle,
          ),
          Card(
            margin: EdgeInsets.only(right: 0),
            shape: roundedRectangle4,
            color: mainColor,
            child: InkWell(
              onTap: () => {vm.goToAddItem(this)}, 
              splashColor: Colors.white70,
              customBorder: roundedRectangle4,
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }

  addItemToCard() {
    final snackBar = SnackBar(
      content: Text('added to cart'),
      duration: Duration(milliseconds: 500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    // Provider.of<MyCart>(context).addItem(CartItem(food: food, quantity: 1));
  }
}

  
  class _ViewModel {
    final Map<String, dynamic> items;
    final Map<dynamic, dynamic> requestedItems;
    final Function(_FoodCardState foodCartState) goToAddItem;

    _ViewModel({this.items, this.requestedItems, this.goToAddItem});

    static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        goToAddItem: (foodCartState) async {
        store.dispatch(AddToCart(new ItemState(
          name: foodCartState.name,
          price: foodCartState.price,
          image: foodCartState.image
        )));
        }
      );
  }
}