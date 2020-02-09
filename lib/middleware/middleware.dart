import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:flipperkit_redux_middleware/flipperkit_redux_middleware.dart';

final persistor = Persistor<AppState>(
  storage: FlutterStorage(),
  serializer: JsonSerializer<AppState>(AppState.rehydrationJSON)
);



// Set up middlewares
List<Middleware<AppState>> createMiddleware() {
  return <Middleware<AppState>>[
      thunkMiddleware,
      persistor.createMiddleware(),
      new LoggingMiddleware.printer(),
      new NavigationMiddleware(),
      new FlipperKitReduxMiddleware(
        // Optional, for filtering action types
        filter: (actionType) {
          return actionType.startsWith('\$');
        },
        // Optional, for get action type
        getActionType: (action) {
          return action.toString();
        },
      )
    ];
}



