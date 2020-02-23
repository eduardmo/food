import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/containers/fryo_icons.dart';
import 'package:food/screens/food_card.dart';
import 'package:food/styles/colors.dart';
import 'package:food/styles/styles.dart';
import 'package:redux/redux.dart';

import '../main.dart';
import '../models/app_state.dart';

class CategoryList extends StatefulWidget {
  final String pageTitle;

  CategoryList({Key key, this.pageTitle}) : super(key: key);
  @override
  _CategoryList createState() => _CategoryList();
}

class _CategoryList extends State<CategoryList> {

@override
Widget build(BuildContext context) {
  return new StoreConnector<AppState, _ViewModel>(
    converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
       return Scaffold(
      
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          children: <Widget>[
            buildAppBar(vm),
            // buildFoodFilter(),
            Divider(),
            buildFoodList(vm),
          ],
        ),
      ),
    );   
        }     
    );
  }
  
  Widget buildAppBar(_ViewModel vm) {
    int items = 0;
    // Provider.of<MyCart>(context).cartItems.forEach((cart) {
      // items += cart.quantity;
    // });
    return SafeArea(
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {vm.goToHomePage();}),
          Spacer(),
          IconButton(icon: Icon(Icons.search), onPressed: () { print(vm.requestedItems);}),
          Stack(
            children: <Widget>[
              IconButton(icon: Icon(Icons.shopping_cart)),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Text(
                    '$items',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildFoodList(_ViewModel vm) {
    return Expanded(
      child:OrientationBuilder(builder: (context, orientation){
        return GridView.builder(
        itemCount: vm.requestedItems.length - 1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
       itemBuilder: (BuildContext context, int index) {
         Map<dynamic, dynamic> newMap = new Map<dynamic, dynamic>();
         vm.requestedItems.keys.forEach((key) {
             newMap.addEntries(vm.requestedItems.entries);
         });
        newMap.remove('url');
        print('lalalalal');
      print(newMap);
      return new GridTile(
        child:FoodCard(newMap.keys.elementAt(index), newMap.values.elementAt(index))//just for testing, will fill with image later
      );
  },);
      } )
    );
  }
}
  
  class _ViewModel {
    final Map<String, dynamic> items;
    final Map<dynamic, dynamic> requestedItems;
    final Function() goToHomePage;
    _ViewModel({this.items, this.requestedItems, this.goToHomePage});

    static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
            items: store.state.menu.item.items,
            requestedItems: store.state.menu.requestedList,

            goToHomePage: () async {
            store.dispatch(NavigateToAction.pop());
    },
      );
  }
}