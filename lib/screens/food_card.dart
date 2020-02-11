import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../styles/styles.dart';

class FoodCard extends StatefulWidget {
  // FoodCard(this.food);
   String name;
   Map<String, dynamic> price;

   FoodCard(this.name, this.price);
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> with SingleTickerProviderStateMixin {
  String get name => widget.name;
  Map<String, dynamic> get price => widget.price;

  @override
  void initState() {
    super.initState();
    print(price.values);
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
            buildPriceInfo(),
          ],
        ),
      ),
    );
        });
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      child: Image.network(
        'https://img.icons8.com/color/48/000000/thanksgiving.png',
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height / 6,
        loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
          if (progress == null) return child;
          return Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null),
            ),
          );
        },
      ),
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

  Widget buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            price.values.toString(),
            style: titleStyle,
          ),
          Card(
            margin: EdgeInsets.only(right: 0),
            shape: roundedRectangle4,
            color: mainColor,
            child: InkWell(
              onTap: addItemToCard,
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
      // content: Text('${food.name} added to cart'),
      duration: Duration(milliseconds: 500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
    // Provider.of<MyCart>(context).addItem(CartItem(food: food, quantity: 1));
  }
}

  
  class _ViewModel {
    final Map<String, dynamic> items;
    final Map<dynamic, dynamic> requestedItems;
    _ViewModel({this.items, this.requestedItems});

    static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
            items: store.state.menu.item.items,
            requestedItems: store.state.menu.requestedList
      );
  }
}