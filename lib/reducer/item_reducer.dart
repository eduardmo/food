import 'package:food/actions/item_action.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';

Reducer<List<ItemState>> itemsReducer = combineReducers([
    new TypedReducer<List<ItemState>, RequestItems>(itemsRequestReducer),
    new TypedReducer<List<ItemState>, FilterItems>(filterItems),
    ]);

List<ItemState> itemsRequestReducer(List<ItemState> categoryState, RequestItems action) {
  return action.items;
}

List<ItemState> filterItems(List<ItemState> itemState, FilterItems action) {
 return action.items.where((element) => element.categoryId == action.categoryId).toList();
}