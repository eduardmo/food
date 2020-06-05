import 'package:food/actions/master_order_action.dart';
import 'package:food/models/master_order_state.dart';
import 'package:redux/redux.dart';

Reducer<MasterOrderState> masterOrderReducer = combineReducers([
  new TypedReducer<MasterOrderState, RequestMasterOrders>(requestMasterOrder),
]);

MasterOrderState requestMasterOrder(MasterOrderState orderHistoryState, RequestMasterOrders action) {
  return action.masterOrderStates;
}
