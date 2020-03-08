import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:redux/redux.dart';
import 'package:food/styles/colors.dart';

class AdminMenuDetail extends StatelessWidget {
  final String pageTitle;
  final String menuId;

  AdminMenuDetail({Key key, this.pageTitle, this.menuId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store){return _ViewModel.fromStore(store,menuId);},
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              appBar: AppBar(
                  title: const Text('Fryo Admin'),
                  backgroundColor: primaryColor),
              body: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Menu Name",
                                style: Theme.of(context).textTheme.title),
                            Text("Menu Phone",
                                style: Theme.of(context).textTheme.body1),
                            Text("Menu Address",
                                style: Theme.of(context).textTheme.body1),
                            Text("Menu eMail",
                                style: Theme.of(context).textTheme.body1)
                          ],
                        ),
                        Expanded(
                            child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Menu Items",
                                  style: Theme.of(context).textTheme.title),
                              Icon(Icons.add)
                            ],
                          ),
                          Expanded(
                            child: GridView.count(
                              // Create a grid with 2 columns. If you change the scrollDirection to
                              // horizontal, this would produce 2 rows.
                              crossAxisCount: 2,
                              // Generate 100 Widgets that display their index in the List
                              children: List.generate(10, (index) {
                                return Card(
                                    child: Column(
                                  children: <Widget>[
                                    Container(
                                        height: 120,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                                "https://picsum.photos/150",
                                                fit: BoxFit.fill))),
                                    Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Patat Special"))),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text("€" + "3.1"),
                                            Text("Patat")
                                          ],
                                        ))
                                  ],
                                ));
                              }),
                            ),
                          )
                        ]))
                      ])));
        });
  }
}

class _ViewModel {
  final MenuState menu;

  _ViewModel({this.menu});

  static _ViewModel fromStore(Store<AppState> store,String menuid) {
    MenuState m =store.state.user.adminMenus.where((e){return e.id == menuid;}).first;
    return new _ViewModel(menu: m);
  }
}
