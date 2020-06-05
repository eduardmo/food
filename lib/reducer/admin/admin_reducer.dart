import 'package:food/actions/Admin/admin_master_order_action.dart';
import 'package:food/actions/Admin/admin_menus_action.dart';
import 'package:food/actions/Admin/admin_topuprequest_action.dart';
import 'package:food/actions/Admin/admin_users_action.dart';
import 'package:food/models/admin_state.dart';
import 'package:food/models/master_order_state.dart';
import 'package:redux/redux.dart';

Reducer<AdminState> adminReducer = combineReducers([
  new TypedReducer<AdminState, RequestAdminUsers>(requestAdminUsers),
  new TypedReducer<AdminState, RequestAdminMenu>(requestAdminMenus),
  new TypedReducer<AdminState, RequestAdminTopUpRequest>(
      requestAdminTopUpRequest),
  new TypedReducer<AdminState,RequestAdminMasterOrders>(requestAdminMasterOrders),
  new TypedReducer<AdminState,RequestAdminMasterOrderItems>(requestAdminMasterOrdersItems)

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

AdminState requestAdminMasterOrders(
    AdminState admin, RequestAdminMasterOrders action) {
  return admin.copyWith(masterOrderStates: action.masterOrderStates);
}

AdminState requestAdminMasterOrdersItems(
  AdminState admin, RequestAdminMasterOrderItems action) {

  //Find the in list
  List<MasterOrderState> orderHistoryState =admin.masterOrderStates;
  int index = orderHistoryState.indexWhere(
          (element) => element.id == action.masterOrderState.id);

  //Update the list with the new header
  orderHistoryState[index] = action.masterOrderState;

  return admin.copyWith(masterOrderStates: orderHistoryState);
}