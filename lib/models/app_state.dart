import 'package:flutter/cupertino.dart';
import 'package:food/models/category_state.dart';
import 'package:food/models/items_state.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';
import 'menu_state.dart';
import 'user_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final UserState user;
  final List<MenuState> menus;
  final List<CategoryState> categories;
  final List<ItemState> items;

  AppState({
    List<MenuState> menus,
    List<CategoryState> categories,
    List<ItemState> items,

    AuthState auth,
    UserState user,
  })
      : auth = auth ?? new AuthState(),
        user = user ?? new UserState(),
        menus = menus ?? new List<MenuState>(),
        categories = categories ?? new List<CategoryState>(),
        items = items ?? new List<ItemState>();

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
      auth: json['auth'] == null
          ? null
          : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserState.fromJson(json['user'] as Map<String, dynamic>),
      menus: json['menus'] == null
          ? null
          : (json['menus'] as List).map((e)=>
          e == null ? null : MenuState.fromJson(e as Map<String, dynamic>)).toList() ,
      categories: json['categories'] == null
          ? null
          : (json['categories'] as List).map((e)=>
          e == null ? null : CategoryState.fromJson(e as Map<String, dynamic>)).toList() ,
      items: json['items'] == null
          ? null
          : (json['items'] as List).map((e)=>
          e == null ? null : ItemState.fromJson(e as Map<String, dynamic>)).toList()
  );

  static AppState rehydrationJSON(dynamic json) {
    if (json == null) return null;
    return AppState(
      auth: json['auth'] == null ? null : new AuthState.fromJson(json['auth']),
      user: json['user'] == null ? null : new UserState.fromJson(json['user']),
      menus: json['menus'] == null ? null : (json['menus'] as List).map((e)=> e == null ? null : new MenuState.fromJson(e as Map<String, dynamic>)).toList(),
      categories: json['categories'] == null ? null :(json['categories'] as List).map((e)=> e == null ? null : new CategoryState.fromJson(e as Map<String, dynamic>)).toList(),
      items: json['items'] == null ? null : (json['items'] as List).map((e)=> e == null ? null : new ItemState.fromJson(e as Map<String, dynamic>)).toList()
    );
  }

  Map<String, dynamic> toJson() =>
      {'auth': auth.toJson(), 'user': user.toJson(),'menus': menus,'categories':categories,'items':items};

  AppState copyWith({AuthState auth, List<MenuState> menus, UserState user,List<CategoryState> categories,List<ItemState> items}) {
    return new AppState(
        auth: auth ?? this.auth,
        user: user ?? this.user,
        menus: menus ?? this.menus,
        categories: categories ?? this.categories,
        items: items ?? this.items,
        );
  }

  @override
  String toString() {
    return '''AppState{
      auth: $auth,
      user: $user,
      menus: $menus,
      categories: $categories,
      items: $items
    }''';
  }
}
