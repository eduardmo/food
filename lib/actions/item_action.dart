import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/app_state.dart';
import '../models/items_state.dart';

class RequestItems {
  final List<ItemState> items;

  RequestItems({this.items});

  @override
  String toString() {
    return 'RequestItems{Items: $items}';
  }
}


ThunkAction<AppState> retrieveItems = (Store<AppState> store) async {
  try {

    //Get all items
    List<ItemState> items = await Firestore.instance
        .collection("Items")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents.map((DocumentSnapshot e){
        double price;

        if(e.data["Price"] is int){
          int i = e.data["Price"];
          price = i.toDouble();
        }else price = e.data["Price"];

        return new ItemState(
          id: e.documentID,
          image: e.data["Image"],
          menuId: e.data["Menu"].documentID,
          categoryId: e.data["Category"].documentID,
          name: e.data["Name"],
          price:price
        );
      }).toList();
    }).catchError((error) => {print(error)});

    store.dispatch(RequestItems(items:items));

  } catch (error) {

    print(error);
  }
};
