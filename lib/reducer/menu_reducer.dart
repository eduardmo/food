import 'package:food/actions/menu_actions.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';

import '../actions/menu_actions.dart';

Reducer<MenuState> menuReducer = combineReducers([
    new TypedReducer<MenuState, RequestMenu>(menuRequestreducer),
    new TypedReducer<MenuState, RequestCategoryList>(requestCategoryListReducer)
]);

MenuState menuRequestreducer(MenuState menuState, RequestMenu action) {
  return menuState.copyWith(
      Name: action.menu.Name,
    item: action.menu.item,
    requestedList: menuState.requestedList
  );
}

MenuState requestCategoryListReducer(MenuState menuState, RequestCategoryList action) {
    return menuState.copyWith(
        Name: menuState.Name,
    item: menuState.item,
    requestedList: action.requestedList
  );
}