import 'package:food/actions/mybalance_action.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:redux/redux.dart';

Reducer<List<BalanceHistoryState>> balanceReducer = combineReducers([
    new TypedReducer<List<BalanceHistoryState>, RequestBalanceHistory>(requestbalanceHistoryReducer),
]);

List<BalanceHistoryState> requestbalanceHistoryReducer(List<BalanceHistoryState> balanceHistory, RequestBalanceHistory action) {
  return action.balanceHistory;
}