import 'package:food/actions/user_action.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';

Reducer<UserState> userReducer = combineReducers([
  new TypedReducer<UserState, SetUserState>(setUserState),
]);

UserState setUserState(UserState user, SetUserState action) {
  return user.copyWith(
      name: action.userState.name,
      email: action.userState.email,
      isAdmin: action.userState.isAdmin,
      balance: action.userState.balance,
      uid: action.userState.uid);
}