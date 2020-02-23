import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/middleware/middleware.dart';
import 'package:food/models/app_state.dart';
import 'package:food/screens/admin/managemenu_screen.dart';
import 'package:food/screens/category_list.dart';
import 'package:food/screens/dashboard.dart';
import 'package:food/screens/product_page.dart';
import 'package:food/store/store.dart';

import 'screens/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    FlipperClient flipperClient = FlipperClient.getDefault();
  flipperClient.addPlugin(new FlipperNetworkPlugin());
  flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
  // flipperClient.addPlugin(new FlipperDatabaseBrowserPlugin());
  flipperClient.addPlugin(new FlipperReduxInspectorPlugin());
  flipperClient.start();

  final initialState = await persistor.load();
  runApp(FoodApp(initialState));
}

class FoodApp extends StatelessWidget {
  var store;
  var initialState;
    
  FoodApp(initialState) {
    this.store = createStore(initialState);
 
  }

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
        return _buildRoute(settings, HomePage());
      case '/dashboard':
        return _buildRoute(settings, Dashboard());
      case '/categoryList':
        return _buildRoute(settings, CategoryList());
      case '/addItem':
        return _buildRoute(settings, ProductPage("hallo"));
      case '/admin':
        return _buildRoute(settings, ManageMenu());


      default:
       return  this.store.state.auth.loginSuccess ? _buildRoute(settings, Dashboard()) : _buildRoute(settings, HomePage());
    }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
