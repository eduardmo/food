import 'package:food/actions/Admin/admin_menus_action.dart';
import 'package:food/actions/Admin/admin_topuprequest_action.dart';
import 'package:food/actions/Admin/admin_users_action.dart';
import 'package:food/models/admin_state.dart';
import 'package:redux/redux.dart';

Reducer<AdminState> adminReducer = combineReducers([
  new TypedReducer<AdminState, RequestAdminUsers>(requestAdminUsers),
  new TypedReducer<AdminState, RequestAdminMenu>(requestAdminMenus),
  new TypedReducer<AdminState, RequestAdminTopUpRequest>(
      requestAdminTopUpRequest),
]);

AdminState requestAdminMenus(AdminState admin, RequestAdminMenu action) {
  return admin.copyWith(menus: action.menus);
}

AdminState requestAdminUsers(AdminState admin, RequestAdminUsers action) {
  return admin.copyWith(users: action.users);
}

AdminState requestAdminTopUpRequest(
    AdminState admin, RequestAdminTopUpRequest action) {
  return admin.copyWith(topUpRequestStates: action.topUpRequestState);
}
