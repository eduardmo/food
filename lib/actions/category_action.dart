import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/category_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../models/app_state.dart';

class RequestCategories {
  List<CategoryState> categories;
  RequestCategories(this.categories);
  @override
  String toString() {
    return 'RequestCategories{Categories: $categories}';
  }
}

ThunkAction<AppState> retrieveCategories = (Store<AppState> store) async {
  try {
    //Get all Categories
    List<CategoryState> categories = await Firestore.instance
        .collection("Categories")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents.map((DocumentSnapshot e){
        return new CategoryState(
          id: e.documentID,
          categoryName: e.data["CategoryName"],
          image: e.data["Image"],
          menuId: e.data["Menu"].documentID
        );
      }).toList();
    }).catchError((error) => {print(error)});
    store.dispatch(RequestCategories(categories));

  } catch (error) {
    print(error);
  }
};
