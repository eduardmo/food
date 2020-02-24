import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/Admin/admin_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';
class MenuManagement extends StatelessWidget {
  final String pageTitle;

  MenuManagement({Key key, this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            "Menu Management",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline4,
                            textAlign: TextAlign.left
                        ),
                      ),
                      ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true, // use it
                          children: vm.menus.map((MenuState e) {
                            return Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(e.Name)
                                ));
                          }).toList()
                      )
                    ])
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Add your onPressed code here!
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          );
        });
  }
}

class _ViewModel {
  final List<MenuState> menus;

  _ViewModel({this.menus});

  static _ViewModel fromStore(Store<AppState> store) {
    if (store.state.user.adminMenus == null) {
      store.dispatch(retrieveAdminMenus);
      return new _ViewModel(
          menus: new List<MenuState>()
      );
    }

    print(store.state.user.adminMenus);
    return new _ViewModel(
        menus: store.state.user.adminMenus
    );
  }
}
