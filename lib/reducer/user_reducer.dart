import 'package:food/actions/Admin/admin_action.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/models/cart_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';

Reducer<UserState> userReducer = combineReducers([
  new TypedReducer<UserState, SetUserState>(setUserState),
  new TypedReducer<UserState, RequestAdminMenu>(requestAdminMenus),
]);

UserState setUserState(UserState User, SetUserState action) {
  return User.copyWith(
      name: action.userState.name,
      adminMenus: action.userState.adminMenus,
      email: action.userState.email,
      isAdmin: action.userState.isAdmin,
      uid: action.userState.uid);
}

UserState requestAdminMenus(UserState User, RequestAdminMenu action) {
  return User.copyWith(
      adminMenus: action.menus);
}
