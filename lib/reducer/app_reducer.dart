import 'package:food/actions/auth_action.dart';
import 'package:food/actions/menu_actions.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/reducer/user_reducer.dart';

import 'auth_reducer.dart';
import 'menu_reducer.dart';

AppState appReducer(AppState state, action) {
  print(action.runtimeType);
  switch (action.runtimeType) {
  //Login, logout, login failure only need the auth state to be changed
    case UserLoginRequest:
    case UserLoginFailure:
    case UserLogout:
      return state.copyWith(auth: authReducer(state.auth, action));

  //When login success, we also need to populate the menu state
    case UserLoginSuccess:
      print("masuk sini");
      return state.copyWith(
          auth: authReducer(state.auth, action),
          menu: menuReducer(state.menu, action));

  //Any changes to the menu will be here
    case RequestCategoryList:
    case RequestMenu:
      return state.copyWith(menu: menuReducer(state.menu, action));

  //When we change User, everything must go here
    case SetUserState:
      print("Masuk sini 2");
      return state.copyWith(user: userReducer(state.user, action));
  }

  return state;
}
