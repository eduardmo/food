import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/models/app_state.dart';
import 'package:food/screens/login_screen.dart';
import 'package:food/screens/main_screen.dart';
import 'package:food/store/store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart' as loginScreen;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FoodApp());
}

class FoodApp extends StatelessWidget {
  var store = createStore();
    
  FoodApp() {
    print(store.state);
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
        store: store,
        child: new MaterialApp(
            title: 'ReduxApp',
            routes: <String, WidgetBuilder>{
              '/': (BuildContext context) => new StoreConnector<AppState, dynamic>( 
                        converter: (store) => store.state.auth.loginSuccess, 
                        builder: (BuildContext context, loginSuccess) => loginSuccess  ?  MainScreen() : LoginScreen(backgroundColor1: Color(0xFF444152)  ,
       backgroundColor2: Color(0xFF6f6c7d),
       highlightColor: Color(0xfff65aa3),
       foregroundColor: Colors.white,
       logo: new AssetImage("assets/images/full-bloom.png"),) 
                    ),
              '/login': (BuildContext context) => new LoginScreen(),
              '/main': (BuildContext context) => new MainScreen()
            }));
  }
}
