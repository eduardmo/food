import 'package:flutter/cupertino.dart';
import 'package:food/models/admin_state.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/cart_state.dart';
import 'package:food/models/category_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/topup_request_state.dart';
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
  final List<ItemState> filteredItems;
  final List<BalanceHistoryState> balanceHistory;
  final List<TopUpRequestState> topUpRequest;
  final CartState cartItems;
  final AdminState adminState;

  AppState({
    List<MenuState> menus,
    List<CategoryState> categories,
    List<ItemState> items,
    List<ItemState> filteredItems,
    List<BalanceHistoryState> balanceHistory,
    List<TopUpRequestState> topUpRequest,
    CartState cartItems,
    AuthState auth,
    UserState user,
    AdminState adminState
  })  : auth = auth ?? new AuthState(),
        user = user ?? new UserState(),
        menus = menus ?? new List<MenuState>(),
        categories = categories ?? new List<CategoryState>(),
        items = items ?? new List<ItemState>(),
        cartItems = cartItems ?? new CartState(),
        balanceHistory = balanceHistory ?? new List<BalanceHistoryState>(),
        filteredItems = filteredItems ?? new List<ItemState>(),
        topUpRequest = topUpRequest ?? new List<TopUpRequestState>(),
        adminState = adminState ?? new AdminState()
        ;

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
        auth: json['auth'] == null
            ? null
            : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
        user: json['user'] == null
            ? null
            : UserState.fromJson(json['user'] as Map<String, dynamic>),
        menus: json['menus'] == null
            ? null
            : (json['menus'] as List)
                .map((e) => e == null
                    ? null
                    : MenuState.fromJson(e as Map<String, dynamic>))
                .toList(),
        categories: json['categories'] == null
            ? null
            : (json['categories'] as List)
                .map((e) => e == null
                    ? null
                    : CategoryState.fromJson(e as Map<String, dynamic>))
                .toList(),
        items: json['items'] == null
            ? null
            : (json['items'] as List)
                .map((e) => e == null
                    ? null
                    : ItemState.fromJson(e as Map<String, dynamic>))
                .toList(),
        filteredItems: json['filteredItems'] == null
            ? null
            : (json['filteredItems'] as List)
                .map((e) => e == null
                    ? null
                    : ItemState.fromJson(e as Map<String, dynamic>))
                .toList(),
        cartItems: json['cartItems'] == null
            ? null
            : CartState.fromJson(json['cartState'] as Map<String, dynamic>),
        balanceHistory: json['balanceHistory'] == null
            ? null
            : (json['balanceHistory'] as List)
                .map((e) => e == null
                    ? null
                    : BalanceHistoryState.fromJson(e as Map<String, dynamic>))
                .toList(),
        topUpRequest: json['topUpRequest'] == null
            ? null
            : (json['topUpRequest'] as List)
                .map((e) => e == null
                    ? null
                    : TopUpRequestState.fromJson(e as Map<String, dynamic>))
                .toList(),
      );

  static AppState rehydrationJSON(dynamic json) {
    if (json == null) return null;
    return AppState(
      auth: json['auth'] == null ? null : new AuthState.fromJson(json['auth']),
      user: json['user'] == null ? null : new UserState.fromJson(json['user']),
      menus: json['menus'] == null
          ? null
          : (json['menus'] as List)
              .map((e) => e == null
                  ? null
                  : new MenuState.fromJson(e as Map<String, dynamic>))
              .toList(),
      categories: json['categories'] == null
          ? null
          : (json['categories'] as List)
              .map((e) => e == null
                  ? null
                  : new CategoryState.fromJson(e as Map<String, dynamic>))
              .toList(),
      balanceHistory: json['balanceHistory'] == null
          ? null
          : (json['balanceHistory'] as List)
              .map((e) => e == null
                  ? null
                  : new BalanceHistoryState.fromJson(e as Map<String, dynamic>))
              .toList(),
      topUpRequest: json['topUpRequest'] == null
          ? null
          : (json['topUpRequest'] as List)
              .map((e) => e == null
                  ? null
                  : new TopUpRequestState.fromJson(e as Map<String, dynamic>))
              .toList(),
      items: json['items'] == null
          ? null
          : (json['items'] as List)
              .map((e) => e == null
                  ? null
                  : new ItemState.fromJson(e as Map<String, dynamic>))
              .toList(),
      filteredItems: json['filteredItems'] == null
          ? null
          : (json['filteredItems'] as List)
              .map((e) => e == null
                  ? null
                  : new ItemState.fromJson(e as Map<String, dynamic>))
              .toList(),
      cartItems: json['cartItems'] == null
          ? null
          : new CartState.fromJson(json['cartItems']),
    );
  }

  Map<String, dynamic> toJson() => {
        'auth': auth.toJson(),
        'user': user.toJson(),
        'menus': menus,
        'categories': categories,
        'items': items,
        'filteredItems': filteredItems,
        'cartItems': cartItems,
        'topUpRequest': topUpRequest,
        'balanceHistory': balanceHistory
      };

  AppState copyWith(
      {AuthState auth,
      List<MenuState> menus,
      UserState user,
      List<CategoryState> categories,
      List<ItemState> items,
      List<ItemState> filteredItems,
      CartState cartItems,
      List<BalanceHistoryState> balanceHistory,
      List<TopUpRequestState> topUpRequest,
      AdminState adminState}) {
    return new AppState(
      auth: auth ?? this.auth,
      user: user ?? this.user,
      menus: menus ?? this.menus,
      categories: categories ?? this.categories,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      cartItems: cartItems ?? this.cartItems,
      balanceHistory: balanceHistory ?? this.balanceHistory,
      topUpRequest: topUpRequest ?? this.topUpRequest,
      adminState: adminState ?? this.adminState
    );
  }

  @override
  String toString() {
    return '''AppState{
      auth: $auth,
      user: $user,
      menus: $menus,
      categories: $categories,
      items: $items,
      filteredItems: $filteredItems,
      cartItems: $cartItems,
      balanceHistory: $balanceHistory,
      topUpRequest: $topUpRequest,
    }''';
  }
}
