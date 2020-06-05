import 'package:food/actions/Admin/admin_master_order_action.dart';
import 'package:food/actions/Admin/admin_menus_action.dart';
import 'package:food/actions/Admin/admin_topuprequest_action.dart';
import 'package:food/actions/Admin/admin_users_action.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/master_order_action.dart';
import 'package:food/actions/mybalance_action.dart';
import 'package:food/actions/order_history_action.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/actions/menu_action.dart';
import 'package:food/actions/category_action.dart';
import 'package:food/actions/item_action.dart';

import 'package:food/models/app_state.dart';
import 'package:food/reducer/admin/admin_reducer.dart';
import 'package:food/reducer/balance_history_reducer.dart';
import 'package:food/reducer/cart_reducer.dart';
import 'package:food/reducer/master_order_reducer.dart';
import 'package:food/reducer/order_history_header_reducer.dart';
import 'package:food/reducer/topup_reducer.dart';
import 'package:food/reducer/category_reducer.dart';
import 'package:food/reducer/item_reducer.dart';
import 'package:food/reducer/user_reducer.dart';

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
      return state.copyWith(auth: authReducer(state.auth, action));

    //Any changes to the menus will be here
    case RequestMenus:
      return state.copyWith(menus: menusReducer(state.menus, action));

    //Any changes to the categories will be here
    case RequestCategories:
      return state.copyWith(
          categories: categoriesReducer(state.categories, action));

    case SetActiveCategory:
      return state.copyWith(
        categories: categoriesReducer(state.categories, action)
      );

    //Any changes to the items will be here
    case RequestItems:
      return state.copyWith(items: itemsReducer(state.items, action));

    case FilterItems:
      return state.copyWith(filteredItems: itemsReducer(state.items, action));

    //When we change user, everything must go here
    case SetUserState:
      return state.copyWith(user: userReducer(state.user,action));

    // Logic for the CartState related stuff
    case RequestCartState:
      return state.copyWith(cart: cartReducer(state.cart, action));
    case AddToCart:
      return state.copyWith(cart: cartReducer(state.cart, action));
    case EmptyCart:
      return state.copyWith(cart: cartReducer(state.cart, action));
    case DeleteItem:
      return state.copyWith(cart: cartReducer(state.cart, action));

    //Logic for retrieving master admin state
    case RequestMasterOrders:
    return state.copyWith(masterOrderState: masterOrderReducer(state.masterOrderState, action));

    //Logic for order History
    case CreateOrderHistory:
      return state.copyWith(orderHistoryHeaderState: orderHistoryHeaderReducer(state.orderHistoryHeaderState, action));
    case RequestOrderHistoryHeader:
      return state.copyWith(orderHistoryHeaderState: orderHistoryHeaderReducer(state.orderHistoryHeaderState,action));
    case RequestOrderHistoryItems:
      return state.copyWith(orderHistoryHeaderState: orderHistoryHeaderReducer(state.orderHistoryHeaderState,action));

    //Logic for BalanceHistory / MyBalance
    case RequestBalanceHistory:
      return state.copyWith(
          balanceHistory: balanceReducer(state.balanceHistory, action));

    case RequestTopUpRequest:
      return state.copyWith(
          topUpRequest: topUpReducer(state.topUpRequest, action));

    //Logic for admin
      case RequestAdminMasterOrders:
      case RequestAdminMasterOrderItems:
      case RequestAdminMenu:
      case RequestAdminUsers:
      case RequestAdminTopUpRequest:
        return state.copyWith(adminState: adminReducer(state.adminState, action));
  }

  return state;
}
