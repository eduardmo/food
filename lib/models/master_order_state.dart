import 'package:flutter/material.dart';
import 'package:food/models/order_history_header_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'master_order_state.g.dart';

@JsonSerializable()
@immutable
class MasterOrderState {
  final String id;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final List<OrderHistoryHeaderState>orderHistoryHeaderState;

  MasterOrderState({this.id, this.orderHistoryHeaderState,this.startDateTime, this.endDateTime});

  Map<String, dynamic> toJson() => _$MasterOrderStateToJson(this);

  factory MasterOrderState.fromJson(Map<String, dynamic> json) =>
      _$MasterOrderStateFromJson(json);

  MasterOrderState copyWith(
      {final String id,
      final DateTime startDateTime,
      final DateTime endDateTime,
      final List<OrderHistoryHeaderState> orderHistoryHeaderState
      }) {
    return new MasterOrderState(
        id: id ?? this.id,
        orderHistoryHeaderState:orderHistoryHeaderState??this.orderHistoryHeaderState,
        startDateTime: startDateTime ?? this.startDateTime,
        endDateTime: endDateTime ?? this.endDateTime);
  }

  @override
  String toString() {
    return "{id: $id,startTime:$startDateTime,endTime:$endDateTime}";
  }
}
