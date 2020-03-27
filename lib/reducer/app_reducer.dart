import 'package:food/actions/Admin/admin_action.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/actions/menu_action.dart';
import 'package:food/actions/category_action.dart';
import 'package:food/actions/item_action.dart';

import 'package:food/models/app_state.dart';
import 'package:food/reducer/cart_reducer.dart';
import 'package:food/reducer/user_reducer.dart';
import 'package:food/reducer/category_reducer.dart';
import 'package:food/reducer/item_reducer.dart';

import 'auth_reducer.dart';
import 'menu_reducer.dart';

AppState appReducer(AppState state, action) {
  switch (action.runtimeType) {
  //Login, logout, login failure only need the auth state to be changed
    case UserLoginRequest:
    case UserLoginFailure:
    case UserLogout:
      return state.copyWith(auth: authReducer(state.auth, action));

  //When login success, we also need to populate the menu state
    case UserLoginSuccess:
      return state.copyWith(
          auth: authReducer(state.auth, action));

  //Any changes to the menus will be here
    case RequestMenus:
      return state.copyWith(menus: menusReducer(state.menus, action));

  //Any changes to the categories will be here
    case RequestCategories:
      return state.copyWith(categories: categoriesReducer(state.categories, action));

  //Any changes to the items will be here
    case RequestItems:
      return state.copyWith(items: itemsReducer(state.items, action));

  //When we change User, everything must go here
    case SetUserState:
    case RequestAdminMenu:
      return state.copyWith(user: userReducer(state.user, action));
  // Logic for the CartState related stuff
    case RequestCartState:
      return state.copyWith(cartItems: cartReducer(state.cartItems, action));
    case AddToCart:
      return state.copyWith(cartItems: cartReducer(state.cartItems, action));
    case EmptyCart:
      return state.copyWith(cartItems: cartReducer(state.cartItems, action));
    case DeleteItem:
      return state.copyWith(cartItems: cartReducer(state.cartItems, action));
  //Logic for order
    case CreateOrder:
      return state.copyWith(cartItems: cartReducer(state.cartItems, action));
  }
  return state;
}
