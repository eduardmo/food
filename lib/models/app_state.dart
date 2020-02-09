import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'auth_state.dart';
import 'menu_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final MenuState menu;

  AppState({
    MenuState menu,
    AuthState auth,
  }) : auth = auth ?? new AuthState(),
      menu = menu ?? new MenuState();

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
    auth: json['auth'] == null ? null : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
    menu: json['menu'] == null ? null : MenuState.fromJson(json['menu'] as Map<String, dynamic>)
  );

  static AppState rehydrationJSON(dynamic json) {
    if(json == null) return null;
    return AppState(
          auth: json['auth'] == null ? null : new AuthState.fromJson(json['auth'] ),
          menu: json['menu'] == null ? null : new MenuState.fromJson(json['menu'])   
    );
  }

  Map<String, dynamic> toJson() => {
      'auth': auth.toJson(),
      'menu': menu.toJson()
    };

  AppState copyWith({
    AuthState auth,
    MenuState menu,
  }) {
    return new AppState(
      auth: auth ?? this.auth,
      menu: menu ?? this.menu,
    );
  }

  @override
  String toString() {
    return '''AppState{
      auth: $auth,
      menu: $menu,
    }''';
  }
}
