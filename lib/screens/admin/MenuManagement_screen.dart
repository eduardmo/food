import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/app_state.dart';
import 'package:redux/redux.dart';

class MenuManagement extends StatelessWidget {
  final String pageTitle;

  MenuManagement({Key key, this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Container(
            child: Card(
              // shape: roundedRectangle12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[],
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final Map<String, dynamic> menu;
  final Map<dynamic, dynamic> requestedItems;
  final Function() goToHomePage;

  _ViewModel({this.menu, this.requestedItems, this.goToHomePage});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      goToHomePage: () async {
        store.dispatch(NavigateToAction.pop());
      },
    );
  }
}
