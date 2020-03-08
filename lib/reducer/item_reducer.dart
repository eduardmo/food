import 'package:food/actions/item_action.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';

Reducer<List<ItemState>> itemsReducer = combineReducers([
    new TypedReducer<List<ItemState>, RequestItems>(itemsRequestReducer),
]);

List<ItemState> itemsRequestReducer(List<ItemState> categoryState, RequestItems action) {
  print(action.items);
  return action.items;
}