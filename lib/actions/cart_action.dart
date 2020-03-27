
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/cart_state.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RequestCartState {
  List<ItemState> item;

  RequestCartState(List<ItemState> item);

  @override
  String toString() {
    return 'CartState{cart: $item}';
  }
}

class AddToCart {
  ItemState itemState;

  AddToCart(this.itemState);

    @override
  String toString() {
    return 'AddToCart{item: $itemState}';
  }
}

class EmptyCart {
    @override
  String toString() {
    return 'EmptyCart{}';
  }
}

class DeleteItem {
ItemState itemState;

DeleteItem(this.itemState);

  @override
  String toString() {
    return 'DeleteItem{item: $itemState}';
  }
}

class CreateOrder {
List<ItemState> order;

CreateOrder(this.order);

  @override
  String toString() {
    return 'CreateOrder{order: $order}';
  }
}

ThunkAction<AppState> createOrderMiddleware = (Store<AppState> store) async {
  try {
    Map<String, dynamic> orderData = new Map<String, dynamic>();
    
    store.state.cartItems.order.forEach((order) {
     orderData[UniqueKey().toString()] = order.toJson(); 
    });
 
    await Firestore.instance
      .collection("MenuOrders")
      .add({
        'order': orderData
      });
  }catch(error) {
    print(error);
  }

};
