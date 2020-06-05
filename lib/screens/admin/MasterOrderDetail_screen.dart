import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/Admin/admin_master_order_action.dart';
import 'package:food/actions/Admin/admin_users_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/master_order_state.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';
import 'package:food/styles/colors.dart';

class MasterOrderDetailScreen extends StatelessWidget {
  final String pageTitle;
  final MasterOrderState masterOrderState;

  MasterOrderDetailScreen({Key key, this.pageTitle, this.masterOrderState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(onInit: (store) {
      store.dispatch(retrieveAdminUsers);
      store.dispatch(retrieveAdminMasterOrderItems(masterOrderState));
    }, converter: (store) {
      return _ViewModel.fromStore(store, masterOrderState);
    }, builder: (BuildContext context, _ViewModel vm) {
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
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Orders Management",
                      style: Theme.of(context).textTheme.subtitle2,
                      textAlign: TextAlign.left),
                ),
                generateOrderHistoryHeaderListView(context, vm)
              ])));
    });
  }
}

Container generateOrderHistoryHeaderListView(context, _ViewModel vm) {
  return Container(
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: vm.orderHistoryHeaderState.map((element) {
            return Card(
                child: InkWell(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: generateOrderHistoryListView(
                                    context, element,vm)),
                          
                        )));
          }).toList()));
}

List<Widget> generateOrderHistoryListView(
    context, OrderHistoryHeaderState orderHistoryHeaderState,_ViewModel vm) {
  List<Widget> itemDetailList = List<Widget>();

  //Put Username
  UserState user = vm.adminUser.firstWhere((element) => element.uid ==  orderHistoryHeaderState.userId);
  itemDetailList.add(new Text(user.name + " (${user.email})" ,style:  Theme.of(context).textTheme.subtitle2));

  itemDetailList
      .addAll(orderHistoryHeaderState.orderHistoryStateList.map((element) {
    return new Card(
        child: InkWell(
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Image :${element.image}"),
                      Text("Name :${element.name}"),
                      Text("Price :${element.price}"),
                      Text("Name :${element.quantity}"),
                    ]))));
  }).toList());

  //Put Total
    itemDetailList.add(new Text("Total :${orderHistoryHeaderState.totalprice}" ,style:  Theme.of(context).textTheme.subtitle2));


  return itemDetailList;
}

class _ViewModel {
  final List<UserState> adminUser;
  final Function handleBackButton;
  final List<OrderHistoryHeaderState> orderHistoryHeaderState;
  _ViewModel({this.handleBackButton, this.orderHistoryHeaderState,this.adminUser});

  static _ViewModel fromStore(
      Store<AppState> store, MasterOrderState masterOrderState) {
    return new _ViewModel(
      adminUser:store.state.adminState.users,
        handleBackButton: () {
          store.dispatch(NavigateToAction.pop());
        },
        orderHistoryHeaderState: (() {
          return store.state.adminState.masterOrderStates
                  .firstWhere((element) => element.id == masterOrderState.id)
                  .orderHistoryHeaderState ??
              new List<OrderHistoryHeaderState>();
        }()));
  }
}
