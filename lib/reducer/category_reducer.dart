import 'package:food/actions/category_action.dart';
import 'package:food/models/category_state.dart';
import 'package:redux/redux.dart';

import '../actions/category_action.dart';

Reducer<List<CategoryState>> categoriesReducer = combineReducers([
    new TypedReducer<List<CategoryState>, RequestCategories>(categoryRequestReducer),
    new TypedReducer<List<CategoryState>, SetActiveCategory>(setActiveCategory),
]);

List<CategoryState> categoryRequestReducer(List<CategoryState> categoryState, RequestCategories action) {
  return action.categories;
}

List<CategoryState> setActiveCategory(List<CategoryState> categoryState, SetActiveCategory action) {
  categoryState.forEach((element) { 
    element.isActive = false;
    if(element.id == action.categoryId) {
    element.isActive = true;
  }});
  return categoryState;
}