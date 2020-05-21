import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'balance_history_state.g.dart';

@JsonSerializable()
@immutable
class BalanceHistoryState {
  final String id;
  final double balance;
  final DateTime dateTime;
  final String userid;
  final String type;

  BalanceHistoryState({this.id, this.balance, this.dateTime,this.userid,this.type});

  Map<String, dynamic> toJson() => _$BalanceHistoryStateToJson(this);

  factory BalanceHistoryState.fromJson(Map<String, dynamic> json) =>
      _$BalanceHistoryStateFromJson(json);

  BalanceHistoryState copyWith(
      {final String id,
      final double balance,
      final DateTime dateTime,
      final String type,
      final String userid
      }) {
    return new BalanceHistoryState(
        id: id ?? this.id,
        balance: balance ?? this.balance,
        dateTime: dateTime ?? this.dateTime,
        userid: userid?? this.userid,
        type: type?? this.type);
  }

  @override
  String toString() {
    return "{id: $id,balance:$balance,dateTime:$dateTime,userid:$userid}";
  }
}
