import 'package:food/actions/auth_action.dart';
import 'package:food/models/auth_state.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:food/models/app_state.dart';
import 'auth_reducer.dart';

AppState appReducer(AppState state, action){
    //print(action);
   if (action is UserLoginRequest || action is UserLoginFailure || action is UserLoginSuccess || action is UserLogout) {
    // Increment
    return state.copyWith(
    auth: authReducer(state.auth, action),
    );
  }

  return state;
}
