import 'package:food/actions/category_action.dart';
import 'package:food/models/category_state.dart';
import 'package:redux/redux.dart';

Reducer<List<CategoryState>> categoriesReducer = combineReducers([
    new TypedReducer<List<CategoryState>, RequestCategories>(categoryRequestReducer),
]);

List<CategoryState> categoryRequestReducer(List<CategoryState> categoryState, RequestCategories action) {
  return action.categories;
}