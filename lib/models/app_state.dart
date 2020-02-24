import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';
import 'menu_state.dart';
import 'user_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final MenuState menu;
  final UserState user;

  AppState({
    MenuState menu,
    AuthState auth,
    UserState user,
  })
      : auth = auth ?? new AuthState(),
        menu = menu ?? new MenuState(),
        user = user ?? new UserState();

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
      auth: json['auth'] == null
          ? null
          : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
      menu: json['menu'] == null
          ? null
          : MenuState.fromJson(json['menu'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserState.fromJson(json['user'] as Map<String, dynamic>));

  static AppState rehydrationJSON(dynamic json) {
    if (json == null) return null;
    return AppState(
      auth: json['auth'] == null ? null : new AuthState.fromJson(json['auth']),
      menu: json['menu'] == null ? null : new MenuState.fromJson(json['menu']),
      user: json['user'] == null ? null : new UserState.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() =>
      {'auth': auth.toJson(), 'menu': menu.toJson(), 'user': user.toJson()};

  AppState copyWith({AuthState auth, MenuState menu, UserState user}) {
    return new AppState(
        auth: auth ?? this.auth,
        menu: menu ?? this.menu,
        user: user ?? this.user);
  }

  @override
  String toString() {
    return '''AppState{
      auth: $auth,
      menu: $menu,
      user: $user
    }''';
  }
}
