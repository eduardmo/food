import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

final persistor = Persistor<AppState>(
  storage: FlutterStorage(),
  serializer: JsonSerializer<AppState>(AppState.rehydrationJSON),
  transforms: Transforms(
    onLoad: [
      (state) => state.copyWith(auth: state.auth)
    ]
  )
);

// Set up middlewares
List<Middleware<AppState>> createMiddleware() {
  return <Middleware<AppState>>[
      thunkMiddleware,
      persistor.createMiddleware(),
      new LoggingMiddleware.printer(),
    ];
}




