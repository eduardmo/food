import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


class RequestAdminMenu {
  final List<MenuState> menus;

  RequestAdminMenu(this.menus);

  @override
  String toString() {
    return 'RequestAdminMenu';
  }
}

ThunkAction<AppState> retrieveAdminMenus = (Store<AppState> store) async {
  print("Masuk sini 2");
  try {
    List<DocumentSnapshot> menusDocumentSnapshot = await Firestore.instance
        .collection("Menu")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents;
    }).catchError((error) {
      print(error);
    });

    Iterator<DocumentSnapshot> menusIterator = menusDocumentSnapshot.iterator;
    List<MenuState> menus = new List();
    while (menusIterator.moveNext()) {
      menus.add(new MenuState(
          id: menusIterator.current['DocumentId'],
          Name: menusIterator.current['Name'],
          Address: menusIterator.current['Address'],
          Email: menusIterator.current['Email'],
          Phone: menusIterator.current['Phone'],
          isActive: menusIterator.current['isActive'],
          item: menusIterator.current['item']));
    }

    store.dispatch(new RequestAdminMenu(menus));
  } catch (error) {
    print(error);
  }
};

ThunkAction<AppState> SaveNewMenu(MenuState menuState) {
  return (Store<AppState> store) async {
    try {
      CollectionReference ref = Firestore.instance.collection('Menu');
      ref.add({
        'Address': menuState.Address,
        'Email': menuState.Email,
        'Items': null,
        'Name': menuState.Name,
        'Phone': menuState.Phone,
        'isActive': menuState.isActive
      });

      await store.dispatch(retrieveAdminMenus);
      store.dispatch(NavigateToAction.pop());
    } catch (error) {
      print("Masuk sini 3");
      print(error);
    }
  };
}
