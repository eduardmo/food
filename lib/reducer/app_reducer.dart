import 'package:food/actions/auth_action.dart';
import 'package:food/actions/menu_actions.dart';
import 'package:food/models/auth_state.dart';
import 'package:food/models/app_state.dart';
import 'auth_reducer.dart';
import 'menu_reducer.dart';


AppState appReducer(AppState state, action){
    //print(action);
   if (action is UserLoginRequest || action is UserLoginFailure || action is UserLoginSuccess || action is UserLogout || action is RequestMenu || action is RequestCategoryList) {
    // Increment
    return state.copyWith(
    auth: authReducer(state.auth, action),
    menu: menuReducer(state.menu, action),
    );
  }

  return state;
}
