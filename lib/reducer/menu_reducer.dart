import 'package:food/actions/menu_actions.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';

Reducer<MenuState> menuReducer = combineReducers([
    new TypedReducer<MenuState, RequestMenu>(menuRequestreducer),
]);

MenuState menuRequestreducer(MenuState menuState, RequestMenu action) {
  return menuState.copyWith(
    menuName: action.menu.menuName,
    item: action.menu.item
  );
}