// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_history_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceHistoryState _$BalanceHistoryStateFromJson(Map<String, dynamic> json) {
  return BalanceHistoryState(
    id: json['id'] as String,
    balance: (json['balance'] as num)?.toDouble(),
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    userid: json['userid'] as String,
    type: json['type'] as String,
  );
}

Map<String, dynamic> _$BalanceHistoryStateToJson(
        BalanceHistoryState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'dateTime': instance.dateTime?.toIso8601String(),
      'userid': instance.userid,
      'type': instance.type,
    };
