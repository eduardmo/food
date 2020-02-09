import 'package:food/middleware/middleware.dart';
import 'package:food/models/app_state.dart';
import 'package:food/reducer/app_reducer.dart';
import 'package:redux/redux.dart';

Store<AppState> createStore(initialState) { 
        Store<AppState> store = new Store (
            appReducer,
            initialState:  initialState == null ?  AppState() : initialState,
            middleware: createMiddleware() 
    );
    return store;
}