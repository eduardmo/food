import 'package:food/actions/user_action.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';

Reducer<UserState> userReducer = combineReducers([
  new TypedReducer<UserState, SetUserState>(setUserState),
]);

UserState setUserState(UserState User, SetUserState action) {
  print("Masuk Sini");
  return User.copyWith(
      name: action.userState.name,
      adminMenus: action.userState.adminMenus,
      email: action.userState.email,
      isAdmin: action.userState.isAdmin,
      uid: action.userState.uid);
}
