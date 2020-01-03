import 'package:food/middleware/middleware.dart';
import 'package:food/models/app_state.dart';
import 'package:food/reducer/app_reducer.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> listMiddleWare = new List<Middleware<AppState>>();
Store<AppState> createStore() { 
        Store<AppState> store = new Store (
            appReducer,
            initialState:  AppState(),
            middleware: listMiddleWare 
        ..addAll(createMiddleware())
    );
      persistor.load();
    return store;
}