import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/category_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:food/models/items_state.dart';

import 'package:redux/redux.dart';
import 'package:food/styles/colors.dart';

class AdminMenuDetail extends StatelessWidget {
  final String pageTitle;
  final String menuId;

  AdminMenuDetail({Key key, this.pageTitle, this.menuId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) {
      return _ViewModel.fromStore(store, menuId);
    }, builder: (BuildContext context, _ViewModel vm) {
      return Scaffold(
        appBar: AppBar(
            title: const Text('Fryo Admin'), backgroundColor: primaryColor),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(vm.menu.name,
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(vm.menu.phone,
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(vm.menu.address,
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(vm.menu.email,
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                  Expanded(
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this would produce 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 Widgets that display their index in the List
                      children: List.generate(vm.items.length, (index) {
                        return Card(
                            child: Column(
                          children: <Widget>[
                            Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(vm.items[index].image,
                                        fit: BoxFit.fill))),
                            Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(vm.items[index].name))),
                            Container(
                                padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        "€" + vm.items[index].price.toString()),
                                    Text(vm.categories
                                        .firstWhere((e) =>
                                            e.id == vm.items[index].categoryId)
                                        .categoryName)
                                  ],
                                ))
                          ],
                        ));
                      }),
                    ),
                  )
                ])),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Column(children: [
                      Text("Add Menu"),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          return value.length < 3
                              ? "Please enter Item name"
                              : null;
                        },
                        decoration: InputDecoration(hintText: "Item name"),
                        onSaved: (value) {},
                      ),
                        TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return value.length < 3
                              ? "Please enter price"
                              : null;
                        },
                        decoration: InputDecoration(hintText: "Price"),
                        onSaved: (value) {},
                      ),
                      new DropdownButton<String>(
                        items: vm.categories.map((CategoryState category) {
                          return new DropdownMenuItem<String>(
                            value: category.id,
                            child: new Text(category.categoryName),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      )
                    ]),
                  );
                });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}

class _ViewModel {
  final MenuState menu;
  final List<ItemState> items;
  final List<CategoryState> categories;

  _ViewModel({this.menu, this.items, this.categories});

  static _ViewModel fromStore(Store<AppState> store, String menuid) {
    MenuState m = store.state.menus.where((e) {
      return e.id == menuid;
    }).first;
    List<ItemState> items = store.state.items.where((e) {
      return e.menuId == menuid;
    }).toList();
    List<CategoryState> categories = store.state.categories;

    return new _ViewModel(menu: m, items: items, categories: categories);
  }
}
