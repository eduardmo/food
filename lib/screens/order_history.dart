import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/order_history_action.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:food/models/app_state.dart';
import 'package:food/styles/colors.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Order History'),
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
      children: List.generate(vm.orderHistoryHeaderState.length, (index) {
        return Card(
            child: InkWell(
                onTap:()=>vm.goToOrderHistoryItems(vm.orderHistoryHeaderState[index]),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    Container(height: 1, width: 8),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date :" +
                              DateFormat('yyyy-MM-dd').format(
                                  vm.orderHistoryHeaderState[index].orderdate)),
                          Text("Total Price €" +
                              vm.orderHistoryHeaderState[index].totalprice
                                  .toString()),
                        ])
                  ]),
                )));
      }));
}

class _ViewModel {
  final Function handleBackButton;
  final Function goToOrderHistoryItems;
  final List<OrderHistoryHeaderState> orderHistoryHeaderState;

  _ViewModel(
      {this.handleBackButton,
      this.goToOrderHistoryItems,
      this.orderHistoryHeaderState});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        handleBackButton: () {
          store.dispatch(NavigateToAction.pop());
        },
        goToOrderHistoryItems:
            (OrderHistoryHeaderState orderHistoryHeaderState) {
          //Retrieve Items
          store.dispatch(retrieveOrderHistoryItems(orderHistoryHeaderState));

          //Go to page
          store.dispatch(NavigateToAction.push("/orderhistory/items",arguments: orderHistoryHeaderState));
        },
        orderHistoryHeaderState: store.state.orderHistoryHeaderState?? new List<OrderHistoryHeaderState>());
  }
}
