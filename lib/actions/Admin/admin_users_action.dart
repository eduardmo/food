import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/actions/Admin/admin_topuprequest_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RequestAdminUsers {
  final List<UserState> users;

  RequestAdminUsers({this.users});

  @override
  String toString() {
    return 'RequestAdminUsers';
  }
}

ThunkAction<AppState> retrieveAdminUsers = (Store<AppState> store) async {
  try {
    List<DocumentSnapshot> userDocumentSnapshot = await Firestore.instance
        .collection("user")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents;
    }).catchError((error) {
      print(error);
    });

    Iterator<DocumentSnapshot> usersIterator = userDocumentSnapshot.iterator;
    List<UserState> users = new List();
    while (usersIterator.moveNext()) {
      users.add(new UserState(
        uid: usersIterator.current.documentID,
        name: usersIterator.current['name'],
        email: usersIterator.current['email'],
      ));
    }
    store.dispatch(new RequestAdminUsers(users: users));
  } catch (error) {
    print(error);
  }
};

ThunkAction<AppState> submitBalanceApproval(
    TopUpRequestState topUpRequestState, UserState userState) {
  return (Store<AppState> store) async {
    try {
      //Add to balance (Get balance first)
      double balance = 0;
      DocumentSnapshot user = await Firestore.instance
          .collection("user")
          .document(userState.uid)
          .get();

      //Retrieve Balance
      if (user.data["balance"] is int) {
        int i = user.data["balance"];
        balance = i.toDouble();
      } else
        balance = user.data["balance"];

      if (topUpRequestState.approved) {
        balance += topUpRequestState.balance;
        //Save new balance
        await Firestore.instance
            .collection("user")
            .document(userState.uid)
            .updateData({"balance": balance});

        //Add to Balance History
        await Firestore.instance.collection("BalanceHistory").add({
          "Balance": topUpRequestState.balance,
          "DateTime": DateTime.now(),
          "Type": "PLUS",
          "userid": user.reference
        });
      }

      //Save TopUpRequest
      await Firestore.instance
          .collection("TopUpRequest")
          .document(topUpRequestState.id)
          .updateData({
        "Approved": topUpRequestState.approved,
        "Completed": topUpRequestState.completed,
      });

      //re-retrieve top up request
      store.dispatch(retrieveAdminTopUpRequest());
    } catch (error) {
      print(error);
    }
  };
}
