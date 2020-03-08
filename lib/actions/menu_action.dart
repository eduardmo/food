import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/app_state.dart';

class RequestMenus {
  List<MenuState> menus;

  RequestMenus(this.menus);

  @override
  String toString() {
    return 'RequestMenu{menu: $menus}';
  }
}

ThunkAction<AppState> retrieveMenu = (Store<AppState> store) async {
  try {
    
    //Get All Menus
    List<MenuState> menus = await Firestore.instance
        .collection("Menu")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents.map((DocumentSnapshot e){
        return new MenuState(
          id: e.documentID,
          address: e.data["Address"],
          email: e.data["Email"],
          isActive: e.data["isActive"],
          name: e.data["Name"],
          phone: e.data["Phone"],
        );
      }).toList();
    }).catchError((error) => {print(error)});
    store.dispatch(RequestMenus(menus));

  } catch (error) {
    print(error);
  }
};
