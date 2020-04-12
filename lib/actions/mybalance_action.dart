import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/app_state.dart';

class RequestBalanceHistory {
  List<BalanceHistoryState> balanceHistory;
  RequestBalanceHistory(this.balanceHistory);

  @override
  String toString() {
    return 'RequestBalanceHistory{BalanceHistory: $balanceHistory}';
  }
}

class RequestTopUpRequest {
  List<TopUpRequestState> topUpRequest;
  RequestTopUpRequest(this.topUpRequest);

  @override
  String toString() {
    return 'RequestTopUpRequest{topUpRequest: $topUpRequest}';
  }
}

ThunkAction<AppState> retrieveBalance(String userid) {
  return (Store<AppState> store) async {
    try {
      //Get user balance
      List<BalanceHistoryState> balance = await Firestore.instance
          .collection("BalanceHistory")
          .orderBy("DateTime")
          .getDocuments()
          .then((QuerySnapshot query) async {
        return query.documents.map((DocumentSnapshot e) {
          double balance;

          if (e.data["Balance"] is int) {
            int i = e.data["Balance"];
            balance = i.toDouble();
          } else
            balance = e.data["Balance"];

          return new BalanceHistoryState(
            id: e.documentID,
            balance: balance,
            dateTime: e.data["DateTime"].toDate(),
            type: e.data["Type"].toString(),
            userid: e.data["userid"].documentID,
          );
        }).toList();
      }).catchError((error) => {print(error)});
      store.dispatch(RequestBalanceHistory(balance));
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> retrieveTopUpRequest(String userid) {
  return (Store<AppState> store) async {
    try {
      //Get user balance
      List<TopUpRequestState> topUpRequest = await Firestore.instance
          .collection("TopUpRequest")
          .orderBy("DateTime")
          .getDocuments()
          .then((QuerySnapshot query) async {
        return query.documents.map((DocumentSnapshot e) {
          double balance;
 
          if (e.data["Balance"] is int) {
            int i = e.data["Balance"];
            balance = i.toDouble();
          } else
            balance = e.data["Balance"];

          return new TopUpRequestState(
            id: e.documentID,
            balance: balance,
            dateTime: e.data["DateTime"].toDate(),
            approved: e.data["Approved"],
            completed: e.data["Completed"],
            userid: e.data["userid"].documentID,
            image: e.data["Image"]
          );
        }).toList();
      }).catchError((error) => {print(error)});
      store.dispatch(RequestTopUpRequest(topUpRequest));
    } catch (error) {
      print(error);
    }
  };
}