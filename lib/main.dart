import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/screens/login_screen.dart';
import 'package:food/screens/main_screen.dart';
import 'package:food/store/store.dart';
import 'package:food/middleware/middleware.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_flipperkit/flutter_flipperkit.dart';

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
        return _buildRoute(settings, LoginScreen(backgroundColor1: Color(0xFF444152)  ,
       backgroundColor2: Color(0xFF6f6c7d),
       highlightColor: Color(0xfff65aa3),
       foregroundColor: Colors.white,
       logo: new AssetImage("assets/images/full-bloom.png")));
      case '/main':
        return _buildRoute(settings, MainScreen());
      default: 
       return  this.store.state.auth.loginSuccess ? _buildRoute(settings, MainScreen()) : _buildRoute(settings, LoginScreen(backgroundColor1: Color(0xFF444152)  ,
       backgroundColor2: Color(0xFF6f6c7d),
       highlightColor: Color(0xfff65aa3),
       foregroundColor: Colors.white,
       logo: new AssetImage("assets/images/full-bloom.png"),));
    }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => builder,
    );
  }
}
