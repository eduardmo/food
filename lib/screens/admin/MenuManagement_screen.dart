import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/Admin/admin_menus_action.dart';
import 'package:food/actions/Admin/admin_topuprequest_action.dart';
import 'package:food/actions/Admin/admin_users_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';

class MenuManagement extends StatelessWidget {
  final String pageTitle;

  MenuManagement({Key key, this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          store.dispatch(retrieveAdminUsers);
          store.dispatch(retrieveAdminTopUpRequest());
          store.dispatch(retrieveAdminMenus);
        },
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Menu Management",
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.left),
                  ),
                  ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true, // use it
                      children: vm.menus.map((MenuState e) {
                        return Card(
                            child: InkWell(
                                onTap: () {
                                  vm.onPressMenuDetail(e.id);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(e.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                          Row(
                                            children: <Widget>[
                                              Text(e.email,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              Text(" | ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              Text(e.phone,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                            ],
                                          )
                                        ]))));
                      }).toList())
                ])),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                vm.onPressAddMenu();
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          );
        });
  }
}

class _ViewModel {
  final Function onPressAddMenu;
  final Function onPressMenuDetail;
  final List<MenuState> menus;

  _ViewModel({this.menus, this.onPressAddMenu, this.onPressMenuDetail});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        menus: ((){
          return store.state.adminState.menus ?? List<MenuState>();
        })(),
        onPressAddMenu: () {
          store.dispatch(NavigateToAction.push("/admin/Menu/Add"));
        },
        onPressMenuDetail: (String menuid) {
          store.dispatch(
              NavigateToAction.push("/admin/Menu/Detail", arguments: menuid));
        });
  }
}
