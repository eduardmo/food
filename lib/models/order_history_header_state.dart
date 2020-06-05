import 'package:flutter/material.dart';
import 'package:food/models/order_history_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_history_header_state.g.dart';

@JsonSerializable()
@immutable
class OrderHistoryHeaderState {
  final String uid;
  final DateTime orderdate;
  final double totalprice;
  final String userId;
  final List<OrderHistoryState> orderHistoryStateList;

  OrderHistoryHeaderState(
      {this.uid,
      this.orderdate,
      this.totalprice,
      this.userId,
      this.orderHistoryStateList});

  Map<String, dynamic> toJson() => _$OrderHistoryHeaderStateToJson(this);

  factory OrderHistoryHeaderState.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryHeaderStateFromJson(json);

  OrderHistoryHeaderState copyWith(
      {final String uid,
      final String orderdate,
      final double totalprice,
      final String userId,
      final List<OrderHistoryState> orderHistoryStateList}) {
    return new OrderHistoryHeaderState(
        uid: uid ?? uid ?? this.uid,
        orderdate: orderdate ?? this.orderdate,
        totalprice: totalprice ?? this.totalprice,
        userId: userId ?? this.userId,
        orderHistoryStateList: orderHistoryStateList ?? orderHistoryStateList);
  }

  @override
  String toString() {
    return "{totalPrice: $totalprice}";
  }
}
