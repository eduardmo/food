import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:path/path.dart' as Path;
import '../models/app_state.dart';
import 'dart:io';

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

ThunkAction<AppState> retrieveBalanceHistory(String userid) {
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

      //Get documentReference
      DocumentSnapshot userReference =  await Firestore.instance.collection("user").document(userid).get();

      //Get user balance
      List<TopUpRequestState> topUpRequest = await Firestore.instance
          .collection("TopUpRequest")
          .where("userid",isEqualTo: userReference.reference)
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
      store.dispatch(RequestTopUpRequest(topUpRequest));
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> submitTopUpRequest(TopUpRequestState topUpRequestState) {
  return (Store<AppState> store) async {
    try {
      //Save Image
      StorageReference storageReference = FirebaseStorage.instance
          .ref()
          .child('receipt/${Path.basename(topUpRequestState.image)}}');
      StorageUploadTask uploadTask =
          storageReference.putFile(new File(topUpRequestState.image));
      await uploadTask.onComplete;

      print('File Uploaded');
      String fileURL = await storageReference.getDownloadURL();

      //Retrieve user reference
      DocumentSnapshot user = await Firestore.instance
          .collection("user")
          .document(topUpRequestState.userid)
          .get();

      //Save Database
      await Firestore.instance.collection("TopUpRequest").add({
        "Approved": topUpRequestState.approved,
        "Balance": topUpRequestState.balance,
        "Completed": topUpRequestState.completed,
        "DateTime": DateTime.now(),
        "Image": fileURL,
        "userid": user.reference
      });

      //re-retrieve top up request
      store.dispatch(retrieveTopUpRequest(topUpRequestState.userid));
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> decreaseBalance(double amount) {
  return (Store<AppState> store) async {
    try {
      //Retrieve user reference
      DocumentSnapshot user = await Firestore.instance
          .collection("user")
          .document(store.state.user.uid)
          .get();

        //Save new balance
        await Firestore.instance
            .collection("user")
            .document(store.state.user.uid)
            .updateData({"balance": store.state.user.balance - amount});

        //Add to Balance History
        await Firestore.instance.collection("BalanceHistory").add({
          "Balance": amount,
          "DateTime": DateTime.now(),
          "Type": "MINUS",
          "userid": user.reference
        });

      //re-retrieve balance & balance history from database
      store.dispatch(SetUserState(store.state.user.copyWith(balance:store.state.user.balance - amount)));
    } catch (error) {
      print(error);
    }
  };
}
