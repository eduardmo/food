import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/master_order_state.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:food/models/order_history_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RequestAdminMasterOrders {
  final List<MasterOrderState> masterOrderStates;

  RequestAdminMasterOrders(this.masterOrderStates);

  @override
  String toString() {
    return 'RequestMasterOrders';
  }
}

class RequestAdminMasterOrderItems {
  final MasterOrderState masterOrderState;

  RequestAdminMasterOrderItems(this.masterOrderState);

  @override
  String toString() {
    return 'RequestMasterOrderItems';
  }
}

ThunkAction<AppState> retrieveAdminMasterOrders =
    (Store<AppState> store) async {
  try {
    //Get all Master menu
    List<MasterOrderState> masterOrderStates = await Firestore.instance
        .collection("MasterOrder")
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents.map((DocumentSnapshot e) {
        return new MasterOrderState(
            id: e.documentID,
            startDateTime: e.data["startDateTime"].toDate(),
            endDateTime: e.data["endDateTime"].toDate());
      }).toList();
    }).catchError((error) => {print(error)});
    store.dispatch(RequestAdminMasterOrders(masterOrderStates));
  } catch (error) {
    print(error);
  }
};

ThunkAction<AppState> saveNewMasterOrder(MasterOrderState masterOrderState) {
  return (Store<AppState> store) async {
    try {
      CollectionReference ref = Firestore.instance.collection('MasterOrder');
      await ref.add({
        'endDateTime': masterOrderState.endDateTime,
        'startDateTime': masterOrderState.startDateTime,
      });

      await store.dispatch(retrieveAdminMasterOrders);
      store.dispatch(NavigateToAction.pop());
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> retrieveAdminMasterOrderItems(
    MasterOrderState masterOrderState) {
  return (Store<AppState> store) async {
    try {
      //Get OrderHistoryHeader reference
      DocumentSnapshot masterOrderReference = await Firestore.instance
          .collection("MasterOrder")
          .document(masterOrderState.id)
          .get();

      //Get all OrderHistory Header with the same master order
      List<OrderHistoryHeaderState> orderHistoryHeaderState = await Firestore
          .instance
          .collection("UserOrdersHistoryHeader")
          .where("masterorder", isEqualTo: masterOrderReference.reference)
          .getDocuments()
          .then((QuerySnapshot query) async {
        return query.documents.map((DocumentSnapshot e) {
          return new OrderHistoryHeaderState(
              uid: e.documentID,
              totalprice: e.data["totalprice"],
              orderdate: e.data["orderdate"].toDate(),
              userId: e.data["userId"].documentID);
        }).toList();
      }).catchError((error) => {print(error)});

      for (int w = 0; w < orderHistoryHeaderState.length; w++) {
        List<OrderHistoryState> orderHistoryStateList = new List();
        //Get UserOrderHeaderReference
        DocumentSnapshot orderHistoryHeaderReference = await Firestore.instance
            .collection("UserOrdersHistoryHeader")
            .document(orderHistoryHeaderState[w].uid)
            .get();

        //Get order history items
        List<DocumentSnapshot> orderHistoryList = await Firestore.instance
            .collection("UserOrdersHistory")
            .where("orderheader",
                isEqualTo: orderHistoryHeaderReference.reference)
            .getDocuments()
            .then((QuerySnapshot query) async {
          return query.documents;
        }).catchError((error) {
          print(error);
        });

        for (int x = 0; x < orderHistoryList.length; x++) {
          List<dynamic> order = orderHistoryList[x].data["order"];
          for (int y = 0; y < order.length; y++) {
            orderHistoryStateList.add(OrderHistoryState.fromJson(order[y]));
          }
        }

        //Fill orderHistoryStateList
        orderHistoryHeaderState[w] = orderHistoryHeaderState[w]
            .copyWith(orderHistoryStateList: orderHistoryStateList);
      }

      store.dispatch(RequestAdminMasterOrderItems(masterOrderState.copyWith(
          orderHistoryHeaderState: orderHistoryHeaderState)));
    } catch (error) {
      print(error);
    }
  };
}
