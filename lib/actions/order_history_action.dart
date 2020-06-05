import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/mybalance_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:food/models/order_history_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class CreateOrderHistory {
  OrderHistoryHeaderState orderHistory;

  CreateOrderHistory(this.orderHistory);

  @override
  String toString() {
    return 'CreateOrder{order: $orderHistory}';
  }
}

class RequestOrderHistoryHeader {
  final List<OrderHistoryHeaderState> orderHistoryHeader;

  RequestOrderHistoryHeader(this.orderHistoryHeader);

  @override
  String toString() {
    return 'RetrieveOrderHistoryHeader';
  }
}

class RequestOrderHistoryItems {
  final OrderHistoryHeaderState orderHistoryHeader;

  RequestOrderHistoryItems(this.orderHistoryHeader);

  @override
  String toString() {
    return 'RetrieveOrderHistory';
  }
}

ThunkAction<AppState> createOrderHistory() {
  return (Store<AppState> store) async {
    try {
      //Master order exist?
      if(store.state.masterOrderState.id == null){
        Fluttertoast.showToast(
          msg: "Order not opened at this moment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return;
      }

      //get master order references
      //Get User Reference
      DocumentSnapshot masterOrder = await Firestore.instance
          .collection("MasterOrder")
          .document(store.state.masterOrderState.id)
          .get();

      List<OrderHistoryState> orderHistoryList = new List<OrderHistoryState>();

      for (int x = 0; x < store.state.cart.length; x++) {
        //Find order already exist in the list
        int exist = orderHistoryList
            .indexWhere((element) => element.name == store.state.cart[x].name);

        //If no element exist, create a new one and append the item
        if (exist == -1) {
          OrderHistoryState s = new OrderHistoryState(
              name: store.state.cart[x].name,
              image: store.state.cart[x].image,
              price: store.state.cart[x].price,
              quantity: 1);
          orderHistoryList.add(s);
          //If element exist, update the quantity
        } else {
          OrderHistoryState s = orderHistoryList[exist];
          s = s.copyWith(quantity: s.quantity + 1);
          orderHistoryList[exist] = s;
        }
      }

      //Calculate total price
      double totalPrice = 0;
      for (int x = 0; x < orderHistoryList.length; x++) {
        totalPrice += orderHistoryList[x].price * orderHistoryList[x].quantity;
      }

      if (store.state.user.balance - totalPrice < 0) {
        Fluttertoast.showToast(
          msg: "You don't have enough balance. Please topup",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        return;
      }

      //Get User Reference
      DocumentSnapshot user = await Firestore.instance
          .collection("user")
          .document(store.state.user.uid)
          .get();

      //Update balance
      store.dispatch(decreaseBalance(totalPrice));

      //Create Order History Header state
      OrderHistoryHeaderState orderHistoryHeaderState =
          new OrderHistoryHeaderState(
              userId: user.documentID,
              orderdate: DateTime.now(),
              totalprice: totalPrice,
              orderHistoryStateList: orderHistoryList);

      //Save to order header to database
      DocumentReference orderHeader =
          await Firestore.instance.collection("UserOrdersHistoryHeader").add({
        'userId': user.reference,
        'masterorder': masterOrder.reference,
        'orderdate': orderHistoryHeaderState.orderdate,
        'totalprice': orderHistoryHeaderState.totalprice
      });

      //Save orders to database
      await Firestore.instance.collection("UserOrdersHistory").add({
        'order': orderHistoryList.map((e) => e.toJson()).toList(),
        'orderheader': orderHeader
      });

      store.dispatch(CreateOrderHistory(orderHistoryHeaderState));

      //Empty Cart
      store.dispatch(EmptyCart());
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> retrieveOrderHistoryHeaders() {
  return (Store<AppState> store) async {
    try {
      //Get User Reference
      DocumentSnapshot userReference = await Firestore.instance
          .collection("user")
          .document(store.state.user.uid)
          .get();

      List<DocumentSnapshot> orderHistoryHeaders = await Firestore.instance
          .collection("UserOrdersHistoryHeader")
          .where("userId", isEqualTo: userReference.reference)
          .getDocuments()
          .then((QuerySnapshot query) async {
        return query.documents;
      }).catchError((error) {
        print(error);
      });

      List<OrderHistoryHeaderState> orderHistoryHeadersStateList = new List();
      for (int x = 0; x < orderHistoryHeaders.length; x++) {
        OrderHistoryHeaderState orderHistoryHeaderState =
            new OrderHistoryHeaderState(
                uid: orderHistoryHeaders[x].documentID,
                orderdate: orderHistoryHeaders[x].data["orderdate"].toDate(),
                totalprice: orderHistoryHeaders[x].data["totalprice"],
                userId: orderHistoryHeaders[x].data["userId"].toString());
        orderHistoryHeadersStateList.add(orderHistoryHeaderState);
      }

      await store
          .dispatch(RequestOrderHistoryHeader(orderHistoryHeadersStateList));
    } catch (error) {
      print(error);
    }
  };
}

ThunkAction<AppState> retrieveOrderHistoryItems(
    OrderHistoryHeaderState orderHistoryHeaderState) {
  return (Store<AppState> store) async {
    try {
      //Get OrderHistoryHeader reference
      DocumentSnapshot orderHistoryHeaderReference = await Firestore.instance
          .collection("UserOrdersHistoryHeader")
          .document(orderHistoryHeaderState.uid)
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

      List<OrderHistoryState> orderHistoryStateList = new List();
      for (int x = 0; x < orderHistoryList.length; x++) {
        List<dynamic> order = orderHistoryList[x].data["order"];
        for (int y = 0; y < order.length; y++) {
          orderHistoryStateList.add(OrderHistoryState.fromJson(order[y]));
        }
      }

      await store.dispatch(RequestOrderHistoryItems(orderHistoryHeaderState
          .copyWith(orderHistoryStateList: orderHistoryStateList)));
    } catch (error) {
      print(error);
    }
  };
}
