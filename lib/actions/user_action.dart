import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/cart_state.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetUserState {
  final UserState userState;

  SetUserState(this.userState);

  @override
  String toString() {
    return 'SetUserState {User: $userState}';
  }
}


