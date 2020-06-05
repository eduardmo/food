import 'package:flutter/cupertino.dart';
import 'package:food/models/admin_state.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/category_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/master_order_state.dart';
import 'package:food/models/order_history_header_state.dart';
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
  final List<OrderHistoryHeaderState> orderHistoryHeaderState;
  final List<ItemState> cart;
  final MasterOrderState masterOrderState;
  final AdminState adminState;

  AppState({
    List<ItemState> cart,
    List<MenuState> menus,
    List<CategoryState> categories,
    List<ItemState> items,
    List<ItemState> filteredItems,
    List<BalanceHistoryState> balanceHistory,
    List<TopUpRequestState> topUpRequest,
    List<OrderHistoryHeaderState> orderHistoryHeaderState,
    AuthState auth,
    UserState user,
    MasterOrderState masterOrderState,
    AdminState adminState
  })  : auth = auth ?? new AuthState(),
        user = user ?? new UserState(),
        cart = cart ?? new List<ItemState>(),
        menus = menus ?? new List<MenuState>(),
        categories = categories ?? new List<CategoryState>(),
        items = items ?? new List<ItemState>(),
        balanceHistory = balanceHistory ?? new List<BalanceHistoryState>(),
        filteredItems = filteredItems ?? new List<ItemState>(),
        topUpRequest = topUpRequest ?? new List<TopUpRequestState>(),
        orderHistoryHeaderState = orderHistoryHeaderState ?? new List<OrderHistoryHeaderState>(),
        adminState = adminState ?? new AdminState(),
        masterOrderState = masterOrderState ?? new MasterOrderState(id:null)
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
        orderHistoryHeaderState: json['orderHistoryHeaderState'] == null
            ? null
            : (json['orderHistoryHeaderState'] as List)
                .map((e) => e == null
                    ? null
                    : OrderHistoryHeaderState.fromJson(e as Map<String, dynamic>))
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
      orderHistoryHeaderState:json['orderHistoryHeaderState'] == null
          ? null
          : (json['orderHistoryHeaderState'] as List)
              .map((e) => e == null
                  ? null
                  : new OrderHistoryHeaderState.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'auth': auth.toJson(),
        'user': user.toJson(),
        'menus': menus,
        'categories': categories,
        'items': items,
        'filteredItems': filteredItems,
        'topUpRequest': topUpRequest,
        'balanceHistory': balanceHistory,
        'orderHistoryHeaderState':orderHistoryHeaderState
      };

  AppState copyWith(
      {AuthState auth,
      List<MenuState> menus,
      UserState user,
      List<CategoryState> categories,
      List<ItemState> items,
      List<ItemState> filteredItems,
      List<ItemState> cart,
      List<BalanceHistoryState> balanceHistory,
      List<TopUpRequestState> topUpRequest,
      List<OrderHistoryHeaderState> orderHistoryHeaderState,
      MasterOrderState masterOrderState,
      AdminState adminState}) {
    return new AppState(
      auth: auth ?? this.auth,
      user: user ?? this.user,
      menus: menus ?? this.menus,
      categories: categories ?? this.categories,
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      cart: cart ?? this.cart,
      balanceHistory: balanceHistory ?? this.balanceHistory,
      topUpRequest: topUpRequest ?? this.topUpRequest,
      adminState: adminState ?? this.adminState,
      masterOrderState: masterOrderState?? this.masterOrderState,
      orderHistoryHeaderState:orderHistoryHeaderState??orderHistoryHeaderState
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
      cart: $cart,
      balanceHistory: $balanceHistory,
      topUpRequest: $topUpRequest,
    }''';
  }
}
