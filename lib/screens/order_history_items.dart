import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:food/models/order_history_state.dart';
import 'package:redux/redux.dart';
import 'package:food/models/app_state.dart';
import 'package:food/styles/colors.dart';

class OrderHistoryItemsScreen extends StatelessWidget {
  final OrderHistoryHeaderState orderHistoryHeaderState;
  OrderHistoryItemsScreen({this.orderHistoryHeaderState});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: (store) =>
            _ViewModel.fromStore(store, orderHistoryHeaderState),
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Order History items'),
                backgroundColor: primaryColor,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    vm.handleBackButton();
                  },
                ),
              ),
              body: Container(
                child: generateOrderHistoryListView(context, vm),
              ));
        });
  }
}

ListView generateOrderHistoryListView(context, _ViewModel vm) {
  return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(vm.orderHistoryState.length, (index) {
        return Card(
            child: InkWell(
                onTap: null,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    Container(height: 1, width: 8),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Image :${vm.orderHistoryState[index].image}"),
                          Text("Name :${vm.orderHistoryState[index].name}"),
                          Text("Price :${vm.orderHistoryState[index].price}"),
                          Text("Name :${vm.orderHistoryState[index].quantity}"),
                        ])
                  ]),
                )));
      }));
}

class _ViewModel {
  final Function handleBackButton;
  final List<OrderHistoryState> orderHistoryState;

  _ViewModel({this.handleBackButton, this.orderHistoryState});

  static _ViewModel fromStore(
      Store<AppState> store, OrderHistoryHeaderState orderHistoryHeaderState) {
    return new _ViewModel(
        handleBackButton: () {
          store.dispatch(NavigateToAction.pop());
        },
        orderHistoryState: (() {
          return store.state.orderHistoryHeaderState
              .firstWhere(
                  (element) => element.uid == orderHistoryHeaderState.uid)
              .orderHistoryStateList ?? new List<OrderHistoryState>();
        }()));
  }
}
