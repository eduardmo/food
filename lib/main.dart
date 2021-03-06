import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/middleware/middleware.dart';
import 'package:food/models/app_state.dart';
import 'package:food/screens/BalanceHistory.dart';
import 'package:food/screens/admin/AdminDashboard_screen.dart';
import 'package:food/screens/admin/MasterOrderDetail_screen.dart';
import 'package:food/screens/admin/createmenu_screen.dart';
import 'package:food/screens/dashboard.dart';
import 'package:food/screens/admin/MenuDetail_screen.dart';
import 'package:food/screens/order_history.dart';
import 'package:food/screens/order_history_items.dart';
import 'package:food/store/store.dart';
import 'package:redux/redux.dart';
import 'screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    FlipperClient flipperClient = FlipperClient.getDefault();
  flipperClient.addPlugin(new FlipperNetworkPlugin());
  flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
  // flipperClient.addPlugin(new FlipperDatabaseBrowserPlugin());
  flipperClient.addPlugin(new FlipperReduxInspectorPlugin());
  flipperClient.start();

  final initialState = await persistor.load();
  Store<AppState> store = createStore(initialState);
  runApp(FoodApp(store:store, initialState:initialState));
}

class FoodApp extends StatelessWidget {
  final Store<AppState> store;
  final AppState initialState;
    
  FoodApp({this.store, this.initialState});
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
            title: 'ReduxApp',
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
        
        ));
  }

Route _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return _buildRoute(settings, LoginScreen());
      case '/dashboard':
        return _buildRoute(settings, Dashboard());
      case '/dashboard/myBalance':
        return _buildRoute(settings, MyBalance());
      case '/orderhistory':
        return _buildRoute(settings, OrderHistoryScreen());
      case '/orderhistory/items':
        return _buildRoute(settings, OrderHistoryItemsScreen(orderHistoryHeaderState: settings.arguments));
      case '/admin':
        return _buildRoute(settings, AdminDashboard());
      case '/admin/masterorder/items':
        return _buildRoute(settings, MasterOrderDetailScreen(masterOrderState: settings.arguments));
      case '/admin/Menu/Add':
        return _buildRoute(settings, CreateMenu());
      case '/admin/Menu/Detail':
        return _buildRoute(settings, AdminMenuDetail(menuId:settings.arguments));
      default:
       return  this.store.state.auth.loginSuccess ? _buildRoute(settings, Dashboard()) : _buildRoute(settings, LoginScreen());
    }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
