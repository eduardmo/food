import 'package:food/actions/menu_action.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';

Reducer<List<MenuState>> menusReducer = combineReducers([
    new TypedReducer<List<MenuState>, RequestMenus>(menuRequestReducer),
]);

List<MenuState> menuRequestReducer(List<MenuState> menuState, RequestMenus action) {
  return action.menus;
}