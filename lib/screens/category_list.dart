import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/items_state.dart';
import 'package:food/screens/food_card.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';

class CategoryList extends StatefulWidget {
  final String pageTitle;
  final String categoryId;

  CategoryList({Key key, this.pageTitle, this.categoryId}) : super(key: key);

  @override
  _CategoryList createState() => _CategoryList(categoryId: categoryId);
}

class _CategoryList extends State<CategoryList> {
  final String categoryId;
  _CategoryList({this.categoryId});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) {
      return _ViewModel.fromStore(store, categoryId);
    }, builder: (BuildContext context, _ViewModel vm) {
      return Scaffold(
        backgroundColor: Color(0xffF4F7FA),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: <Widget>[
              buildAppBar(vm),
              //buildFoodFilter (),
              Divider(),
              buildFoodList(vm),
            ],
          ),
        ),
      );
    });
  }

  Widget buildAppBar(_ViewModel vm) {
    int items = vm.itemCartCount;
    // Provider.of<MyCart>(context).cartItems.forEach((cart) {
    // items += cart.quantity;
    // });
    return SafeArea(
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                vm.goToHomePage();
              }),
          Spacer(),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              }),
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    vm.goToCartPage();
                  }),
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
    return Expanded(child: OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
        itemCount: vm.items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
        itemBuilder: (BuildContext context, int index) {
          Map<dynamic, dynamic> newMap = new Map<dynamic, dynamic>();
          return new GridTile(
              child: FoodCard(
                  vm.items.elementAt(index).name,
                  vm.items.elementAt(index).price,
                  vm.items.elementAt(index).image
                  ) //just for testing, will fill with image later
              );
        },
      );
    }));
  }
}

class _ViewModel {
  final List<ItemState> items;
  final Function() goToHomePage;
  final int itemCartCount;
  final Function() goToCartPage;
  _ViewModel({this.items, this.goToHomePage, this.itemCartCount, this.goToCartPage});
  static _ViewModel fromStore(Store<AppState> store, String categoryId) {
    return new _ViewModel(
        items:
            store.state.items.where((e) => e.categoryId == categoryId).toList(),
        goToHomePage: () => store.dispatch(NavigateToAction.pop()),
        itemCartCount: store.state.cartItems.itemState == null ? 0 : store.state.cartItems.itemState.length,
        goToCartPage: () => store.dispatch(NavigateToAction.push('/cart')),
        );
  }
}
