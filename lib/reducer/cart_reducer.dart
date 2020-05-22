import 'package:food/actions/cart_action.dart';
import 'package:food/models/cart_state.dart';
import 'package:redux/redux.dart';

Reducer<CartState> cartReducer = combineReducers([
  new TypedReducer<CartState, RequestCartState>(requestCartState),
  new TypedReducer<CartState, AddToCart>(addToCart),
  new TypedReducer<CartState, EmptyCart>(emptyCart),
  new TypedReducer<CartState, DeleteItem>(deleteItem),
  new TypedReducer<CartState, CreateOrder>(createOrder),
]);


CartState requestCartState(CartState cartState, RequestCartState action) {
  return cartState.copyWith(itemState:  List.from(cartState.itemState));
}

CartState addToCart(CartState cartState, AddToCart action) {
  if(cartState.itemState == null) {
    return CartState().copyWith(itemState: List()..add(action.itemState));
  } else {
    return CartState().copyWith(itemState: List.from(cartState.itemState)..add(action.itemState));
  }
}

CartState emptyCart(CartState cartState, EmptyCart action) {
  return CartState().copyWith(itemState: List());
}

CartState deleteItem(CartState cartState, DeleteItem action) {
  return CartState().copyWith(itemState: List.from(cartState.itemState)..remove(action.itemState));
}
CartState createOrder(CartState userState, CreateOrder action) {
  //When creating an order, empty the items in the cart
 return CartState().copyWith(
   order: action.order,
   itemState: List()
 );
}
