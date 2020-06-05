import 'package:food/actions/order_history_action.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:redux/redux.dart';

Reducer<List<OrderHistoryHeaderState>> orderHistoryHeaderReducer = combineReducers([
  new TypedReducer<List<OrderHistoryHeaderState>, CreateOrderHistory>(createOrderHistory),
  new TypedReducer<List<OrderHistoryHeaderState>, RequestOrderHistoryHeader>(requestOrderHistoryHeader),
  new TypedReducer<List<OrderHistoryHeaderState>,RequestOrderHistoryItems>(requestOrderHistory)
]);

List<OrderHistoryHeaderState> createOrderHistory(List<OrderHistoryHeaderState> orderHistoryState, CreateOrderHistory action) {
  orderHistoryState.add(action.orderHistory);
  return orderHistoryState;
}

List<OrderHistoryHeaderState> requestOrderHistoryHeader(List<OrderHistoryHeaderState> orderHistoryHeaderState, RequestOrderHistoryHeader action) {
  return action.orderHistoryHeader;
}

List<OrderHistoryHeaderState> requestOrderHistory(List<OrderHistoryHeaderState> orderHistoryHeaderState, RequestOrderHistoryItems action) {
  //Find the header
  int index = orderHistoryHeaderState.indexWhere(
          (element) => element.uid == action.orderHistoryHeader.uid);

  //Update the list with the new header
  orderHistoryHeaderState[index] = action.orderHistoryHeader;

  return orderHistoryHeaderState;
}