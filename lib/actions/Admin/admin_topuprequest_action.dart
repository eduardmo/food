import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RequestAdminTopUpRequest {
  final List<TopUpRequestState> topUpRequestState;

  RequestAdminTopUpRequest({this.topUpRequestState});

  @override
  String toString() {
    return 'RequestAdminTopUpRequest';
  }
}

ThunkAction<AppState> retrieveAdminTopUpRequest() {
  return (Store<AppState> store) async {
    try {


      print("Masuk sini");
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
              image: e.data["Image"]);
        }).toList();
      }).catchError((error) => {print(error)});
      store.dispatch(RequestAdminTopUpRequest(topUpRequestState: topUpRequest));
    } catch (error) {
      print(error);
    }
  };
}