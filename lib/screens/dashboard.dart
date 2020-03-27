import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/actions/category_action.dart';
import 'package:food/actions/menu_action.dart';
import 'package:food/actions/item_action.dart';
import 'package:food/containers/fryo_icons.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/category_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/user_state.dart';
import 'package:food/styles/colors.dart';
import 'package:food/styles/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import 'dashboard_page/dashboard_settings.dart';

class Dashboard extends StatefulWidget {
  final String pageTitle;

  Dashboard({Key key, this.pageTitle}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
   Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          final _tabs = [
            storeTab(context, vm),
            Text('Tab3'),
            Text('Tab4'),
            DashboardSettings(
                vm.user.isAdmin,
                vm.onAdminButtonClicked,
                vm.onUserProfileClicked,
                vm.onPressLogOut),
          ];
          return Scaffold(

              backgroundColor: bgColor,
              appBar: PreferredSize(
                preferredSize: preferredSize,
                child: buildAppBar(vm),
              ),
              body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up load");
                    }
                    else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    }
                    else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    }
                    else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    }
                    else {
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
                child: _tabs[_selectedIndex],
              ),

              bottomNavigationBar: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.store),
                      title: Text(
                        'Store',
                        style: tabLinkStyle,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      title: Text(
                        'Profile',
                        style: tabLinkStyle,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      title: Text(
                        'Settings',
                        style: tabLinkStyle,
                      ))
                ],
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.green[600],
                onTap: _onItemTapped,
              )
          );
        }
    );
  }

  Widget buildAppBar(_ViewModel vm) {
    int items = vm.order.length;
    // Provider.of<MyCart>(context).cartItems.forEach((cart) {
    // items += cart.quantity;
    // });
    return SafeArea(
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                vm.goToHomePage();
              }),
          Spacer(),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
              }),
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    vm.goToCartPage();
                  }),
              Positioned(
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Text(
                    '$items',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

Widget storeTab(BuildContext context, _ViewModel vm) {
  return ListView(children: <Widget>[
    headerTopCategories(vm),
    deals('Last order', vm, onViewMore: () {}, items: <Widget>[]),
    deals('Last order', vm, onViewMore: () {}, items: <Widget>[]),
  ]);
}

Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
          child: Text('View all ›', style: contrastText),
        ),
      )
    ],
  );
}

// wrap the horizontal listview inside a sizedBox..
Widget headerTopCategories(_ViewModel vm) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      sectionHeader('All Categories', onViewMore: () {}),
      SizedBox(
        height: 130,
        child: ListView.builder(
          itemCount: vm.categories.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, int i) {
            CategoryState category = vm.categories.elementAt(i);
            return headerCategoryItem(category.categoryName, category.image,
                onPressed: () => {vm.onListCategoryItems(category.id)});
          },
        ),
      )
    ],
  );
}

Widget headerCategoryItem(String name, String url, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 86,
            height: 86,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Image.network(url),
            )),
        Text(name + ' ›', style: categoryText)
      ],
    ),
  );
}

Widget deals(String dealTitle, _ViewModel vm,
    {onViewMore, List<Widget> items}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader(dealTitle, onViewMore: onViewMore),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vm.order.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(vm.order[index].image),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Row(
                    children: <Widget>[ 
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(vm.order[index].name,
                          
                          style: taglineText),
                    ) 
                  ]
                  ),
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}

class _ViewModel {
  final Function onPressLogOut;
  final Function(RefreshController _refreshController) onRefreshCallback;
  final Function(RefreshController _refreshController) onLoadingCallback;
  final Function onAdminButtonClicked;
  final Function onUserProfileClicked;
  final Function() goToHomePage;
  final Function() goToCartPage;

  final List<ItemState> items;
  final List<CategoryState> categories;

  final UserState user;

  final Function(String categoryId) onListCategoryItems;

  final List<ItemState> order;
  _ViewModel({
    this.onPressLogOut,
    this.onRefreshCallback(RefreshController _refreshController),
    this.onLoadingCallback(RefreshController _refreshController),
    this.onAdminButtonClicked,
    this.onUserProfileClicked,
    this.items,
    this.categories,
    this.user,
    this.onListCategoryItems,
    this.goToCartPage,
    this.goToHomePage,
    this.order,
  });

  static _ViewModel fromStore(Store<AppState> store) {

    return new _ViewModel(
        user: store.state.user,

        order: store.state.cartItems.order == null ? List() : store.state.cartItems.order,
        //Only Retrieve active Categories
        categories: store.state.categories.where((e){return e.menuId == store.state.menus.where((f)=>f.isActive==true).first.id;}).toList(),
        
        //Only Return active Items
        items: store.state.items.where((e)=> e.menuId == store.state.menus.where((f)=>f.isActive==true).first.id).toList(),

        onListCategoryItems: (categoryId) async {
          await store.dispatch(NavigateToAction.push('/categoryList',arguments: categoryId));
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
        onPressLogOut: () {
          store.dispatch(createLogOutMiddleware);
        },
        onAdminButtonClicked: () {
          store.dispatch(NavigateToAction.push('/admin'));
        },
        onUserProfileClicked: () {
          print("onUserProfile Clicked");
        },
        goToHomePage: () => store.dispatch(createLogOutMiddleware),
        goToCartPage: () {
          store.dispatch(NavigateToAction.push('/cart'));
        } ,
        );
  }
}

