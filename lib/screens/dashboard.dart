import 'package:animated_button/animated_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/category_action.dart';
import 'package:food/actions/item_action.dart';
import 'package:food/containers/network_image.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/category_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/user_state.dart';
import 'package:food/screens/admin/AdminDashboard_screen.dart';
import 'package:food/screens/cart.dart';
import 'package:food/screens/order_page.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  TabController controller;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _selectedIndex = 0;

  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          final _tabs = [
            buildBody(vm),
            CartOnePage(),
            OrderPage(),
            AdminDashboard()
          ];
          return Scaffold(
            body: Center(
              child: _tabs[_selectedIndex],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_seat, color: Colors.grey),
                  title: new Text('Menu'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart, color: Colors.grey),
                  title: Text('Shopping cart'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timer, color: Colors.grey),
                  title: new Text('Admin'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.portrait, color: Colors.grey),
                  title: new Text('Admin'),
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildBody(_ViewModel vm) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 250.0,
                  width: double.infinity,
                  color: Colors.indigo.shade500,
                ),
                Positioned(
                  bottom: 50.0,
                  right: 100.0,
                  child: Container(
                      height: 400.0,
                      width: 400.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200.0),
                        color: Colors.indigo.shade300,
                      )),
                ),
                Positioned(
                  bottom: 100.0,
                  left: 150.0,
                  child: Container(
                      height: 300.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0),
                          color: Colors.indigo.shade200)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        SizedBox(width: 15.0),
                        Container(
                          child: GestureDetector(onTap: () {
                            vm.goToHomePage();
                          }),
                          alignment: Alignment.topLeft,
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2.0),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 120.0),
                        Container(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 15.0),
                      ],
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Hello , Pino',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'What do you want to buy?',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(5.0),
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search,
                                    color: Color(getColorHexFromStr('#7CB427')),
                                    size: 30.0),
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Quicksand'))),
                      ),
                    ),
                    SizedBox(height: 10.0)
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                SizedBox(height: 10.0),
                Material(
                    elevation: 1.0,
                    child: Container(height: 75.0, color: Colors.white)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: vm.categories
                        .map<Widget>((element) => Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width / 4,
                            child: Column(
                              children: <Widget>[
                                AnimatedButton(
                                  width: 80,
                                  height: 52,
                                  duration: 70,
                                  enabled: true,
                                  color: element.isActive == true
                                      ? Color.fromRGBO(128, 185, 38, 100)
                                      : Colors.white,
                                  shadowDegree: ShadowDegree.dark,
                                  onPressed: () => {
                                    vm.onListCategoryItems(element.id, vm.items)
                                  },
                                  child: Container(
                                    height: 60,
                                    child: PNetworkImage(element.image),
                                  ),
                                ),
                                Text(
                                  '${element.categoryName}',
                                  style: TextStyle(fontFamily: 'Quicksand'),
                                )
                              ],
                            )))
                        .toList(),
                  ),
                ),
              ],
            ),
            vm.filteredItems == null
                ? itemCard(false, vm.items, vm)
                : itemCard(false, vm.filteredItems, vm)
          ],
        ),
      ],
    );
  }

  Widget itemCard(bool isFavorite, List<ItemState> items, _ViewModel vm) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: this._refreshController,
        onRefresh: () => vm.onRefreshCallback(this._refreshController),
        onLoading: () => vm.onLoadingCallback(this._refreshController),
        child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: vm.filteredItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin: EdgeInsets.only(bottom: 20.0),
              height: 150,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                vm.filteredItems[index].image),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(5.0, 5.0),
                              blurRadius: 10.0)
                        ]),
                  )),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            vm.filteredItems[index].name,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                          Text("${vm.filteredItems[index].price}€",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              )),
                          NiceButton(
                            // width: 255,
                            fontSize: 10,
                            elevation: 8.0,
                            radius: 50,
                            text: "Add To Cart",
                            background: Colors.blueGrey,
                            onPressed: () {
                              vm.goToAddItem(
                                  vm.filteredItems[index].name,
                                  vm.filteredItems[index].image,
                                  vm.filteredItems[index].price,
                                  vm.filteredItems[index].id,
                                  vm.filteredItems[index].menuId);
                            },
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(5.0, 5.0),
                                blurRadius: 10.0)
                          ]),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ViewModel {
  final Function(RefreshController _refreshController) onRefreshCallback;
  final Function(RefreshController _refreshController) onLoadingCallback;
  final Function(
          String title, String image, double price, String id, String menuId)
      goToAddItem;
  final Function() goToHomePage;
  final Function() goToCartPage;
  final List<ItemState> filteredItems;
  final List<ItemState> items;
  final List<CategoryState> categories;
  final UserState user;
  final Function(String categoryId, List<ItemState> items) onListCategoryItems;

  _ViewModel(
      {this.onRefreshCallback(RefreshController _refreshController),
      this.onLoadingCallback(RefreshController _refreshController),
      this.items,
      this.categories,
      this.user,
      this.onListCategoryItems,
      this.goToCartPage,
      this.goToHomePage,
      this.filteredItems,
      this.goToAddItem});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      user: store.state.user,
      //Only Retrieve active Categories
      categories: store.state.categories.where((e) {
        return e.menuId ==
            store.state.menus.where((f) => f.isActive == true).first.id;
      }).toList(),

      goToAddItem: (title, image, price, id, menuId) async {
            Fluttertoast.showToast(
              msg: "Item added to cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );

        store.dispatch(
            AddToCart(new ItemState(name: title, price: price, image: image)));
      },

      //Only Return active Items
      items: store.state.items
          .where((e) =>
              e.menuId ==
              store.state.menus.where((f) => f.isActive == true).first.id)
          .toList(),
      filteredItems: store.state.filteredItems
          .where((e) =>
              e.menuId ==
              store.state.menus.where((f) => f.isActive == true).first.id)
          .toList(),

      onListCategoryItems: (categoryId, items) async {
        store.dispatch(FilterItems(items: items, categoryId: categoryId));
        store.dispatch(
            SetActiveCategory(isActive: true, categoryId: categoryId));
        //     NavigateToAction.push('/categoryList', arguments: categoryId));
      },
      onRefreshCallback: (_refreshController) async {
        await Future.delayed(Duration(milliseconds: 1000));
        await store.dispatch(retrieveCategories);
        await store.dispatch(retrieveItems);

        _refreshController.refreshCompleted();
      },
      onLoadingCallback: (_refreshController) async {
        await Future.delayed(Duration(milliseconds: 1000));
        _refreshController.loadComplete();
      },
      goToHomePage: () => store.dispatch(createLogOutMiddleware),
      goToCartPage: () {
        store.dispatch(NavigateToAction.push('/cart'));
      },
    );
  }
}
