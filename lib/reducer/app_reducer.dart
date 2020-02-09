import 'package:food/actions/auth_action.dart';
import 'package:food/actions/Admin/ManageMenu_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/reducer/admin/ManageMenu_Reducer.dart';
import 'auth_reducer.dart';

AppState appReducer(AppState state, action){
  switch(action){
    case UserLoginRequest:
    case UserLoginFailure:
    case UserLoginSuccess:
    case UserLogout:
      return state.copyWith(auth: authReducer(state.auth, action));
    break;
    case OpenManageMenuAction:
      openManageMenuReducer();
      return state;
    break;
  }
  return state;
}
