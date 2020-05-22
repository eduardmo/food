import 'package:food/actions/mybalance_action.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:redux/redux.dart';

Reducer<List<TopUpRequestState>> topUpReducer = combineReducers([
    new TypedReducer<List<TopUpRequestState>, RequestTopUpRequest>(requestTopUpRequestReducer),
]);

List<TopUpRequestState> requestTopUpRequestReducer(List<TopUpRequestState> balanceHistory, RequestTopUpRequest action) {
  return action.topUpRequest;
}