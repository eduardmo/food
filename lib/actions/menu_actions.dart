import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/app_state.dart';
import '../models/items_state.dart';

class RequestMenu{
  MenuState menu;

  RequestMenu(this.menu);

  @override
  String toString() {
    return 'RequestMenu{menu: $menu}';
  }
}

class RequestCategoryList{
Map<dynamic, dynamic> requestedList;

RequestCategoryList(this.requestedList);

@override
String toString() {
  return 'RequestedList: {requestedList: $requestedList}';
}
}
 

ThunkAction<AppState> retrieveItem = (Store<AppState> store) async {
      try {
       var menuData = await Firestore.instance.collection("Menu").where('isActive', isEqualTo: true).getDocuments().then((QuerySnapshot query ) async{
          return query.documents.toList().first.data;
       })
       .catchError((error) => {
         print(error)
       });
       DocumentReference itemReference = menuData['Items'] as DocumentReference;
      
        var itemdata = itemReference.get().then((DocumentSnapshot snap) {
           return snap.data;
        }) 
        .catchError((error) => {
          print(error)
        });

        store.dispatch( new RequestMenu(new MenuState(menuName: menuData['Name'], item:  new ItemState(items: await itemdata))));
      } catch (error) {
        print(error);
    }
  
};