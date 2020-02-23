import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RequestAdminMenus {
  final List<MenuState> menus;

  RequestAdminMenus(this.menus);

  @override
  String toString() {
    return 'Request Admin Menus{Menus: $menus}';
  }
}

ThunkAction<AppState> retrieveAdminMenus = (Store<AppState> store) async {
  try {
    List<DocumentSnapshot> menusDocumentSnapshot = await Firestore.instance
        .collection("Menu")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents.toList();
    }).catchError((error) => {print(error)});

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

    store.dispatch(new RequestAdminMenus(menus));
  } catch (error) {
    print(error);
  }
};
