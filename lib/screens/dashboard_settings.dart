import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:food/models/app_state.dart';

class DashboardSettings extends StatelessWidget {
  final bool isAdmin;
  DashboardSettings({this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder:  (BuildContext context, _ViewModel vm) {
        return ListView(padding: const EdgeInsets.all(8), children: [
          Visibility(
            visible: isAdmin,
            child: RaisedButton(
              child: Text("Admin"),
              onPressed: vm.onAdminButtonClicked,
            ),
          ),
          RaisedButton(
            child: Text("My Balance"),
            onPressed: vm.onMyBalanceButtonClicked,
          ),
          RaisedButton(
            child: Text("Logout"),
            onPressed: vm.onPressLogOut,
          )
        ]);
        
        });
  }
}

class _ViewModel {
  final Function onPressLogOut;
  final Function onAdminButtonClicked;
  final Function onMyBalanceButtonClicked;

  _ViewModel({
    this.onPressLogOut,
    this.onAdminButtonClicked,
    this.onMyBalanceButtonClicked,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        onPressLogOut: () {
          store.dispatch(createLogOutMiddleware);
        },
        onAdminButtonClicked: () {
          store.dispatch(NavigateToAction.push('/admin'));
        },
        onMyBalanceButtonClicked: () {
          store.dispatch(NavigateToAction.push('/dashboard/myBalance'));
        });
  }
}
