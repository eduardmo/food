import 'package:food/actions/cart_action.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';

Reducer<List<ItemState>> cartReducer = combineReducers([
  new TypedReducer<List<ItemState>, AddToCart>(addToCart),
  new TypedReducer<List<ItemState>, EmptyCart>(emptyCart),
  new TypedReducer<List<ItemState>, DeleteItem>(deleteItem),
]);

List<ItemState> addToCart(List<ItemState> cart, AddToCart action) {
  cart.add(action.order);
  return cart;
}

List<ItemState> emptyCart(List<ItemState> cart, EmptyCart action) {
  return List();
}

List<ItemState> deleteItem(List<ItemState> cart, DeleteItem action) {
  cart.remove(action.cartItem);
  return cart;
}
