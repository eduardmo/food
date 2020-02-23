import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/actions/menu_actions.dart';
import 'package:food/containers/fryo_icons.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/auth_state.dart';
import 'package:food/styles/colors.dart';
import 'package:food/styles/styles.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';

import '../actions/menu_actions.dart';
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

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          final _tabs = [
            storeTab(context, vm),
            Text('Tab2'),
            Text('Tab3'),
            Text('Tab4'),
            DashboardSettings(
                vm.auth.currentUser.isAdmin,
                vm.onAdminButtonClicked,
                vm.onUserProfileClicked,
                vm.onPressLogOut),
          ];
          return Scaffold(

              backgroundColor: bgColor,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    vm.onPressLogOut();
                  },
                  iconSize: 21,
                  icon: Icon(Fryo.funnel),
                ),
                backgroundColor: primaryColor,
                title:
                Text(
                    'Fryo', style: logoWhiteStyle, textAlign: TextAlign.center),
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    iconSize: 21,
                    icon: Icon(Fryo.magnifier),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    iconSize: 21,
                    icon: Icon(Fryo.alarm),
                  )
                ],
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
                      icon: Icon(Fryo.shop),
                      title: Text(
                        'Store',
                        style: tabLinkStyle,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Fryo.cart),
                      title: Text(
                        'My Cart',
                        style: tabLinkStyle,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Fryo.heart_1),
                      title: Text(
                        'Favourites',
                        style: tabLinkStyle,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Fryo.user_1),
                      title: Text(
                        'Profile',
                        style: tabLinkStyle,
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Fryo.cog_1),
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
          itemCount: vm.items.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (_, int i) {
            String key = vm.items.keys.elementAt(i);
            Map<dynamic, dynamic> value = vm.items.values.elementAt(i);
            return headerCategoryItem(key, value['url'],
                onPressed: () => {vm.onListCategoryItems(value)});
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (items != null)
                ? items
                : <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('No items available at this moment.',
                          style: taglineText),
                    )
                  ],
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

  final Map<String, dynamic> items;
  final AuthState auth;

  final Function(Map<dynamic, dynamic> itemValues) onListCategoryItems;

  _ViewModel({
    this.onPressLogOut,
    this.onRefreshCallback(RefreshController _refreshController),
    this.onLoadingCallback(RefreshController _refreshController),
    this.onAdminButtonClicked,
    this.onUserProfileClicked,
    this.items,
    this.auth,
    this.onListCategoryItems
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        items: store.state.menu.item.items,
        auth: store.state.auth,
        onListCategoryItems: (itemValues) async {
          await store.dispatch(RequestCategoryList(itemValues));
          await store.dispatch(NavigateToAction.push('/categoryList'));
        },
        onRefreshCallback: (_refreshController) async {
          await Future.delayed(Duration(milliseconds: 1000));
          await store.dispatch(retrieveItem);
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
        });
  }
}
