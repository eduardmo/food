// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_header_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryHeaderState _$OrderHistoryHeaderStateFromJson(
    Map<String, dynamic> json) {
  return OrderHistoryHeaderState(
    uid: json['uid'] as String,
    orderdate: json['orderdate'] == null
        ? null
        : DateTime.parse(json['orderdate'] as String),
    totalprice: (json['totalprice'] as num)?.toDouble(),
    userId: json['userId'] as String,
    orderHistoryStateList: (json['orderHistoryStateList'] as List)
        ?.map((e) => e == null
            ? null
            : OrderHistoryState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderHistoryHeaderStateToJson(
        OrderHistoryHeaderState instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'orderdate': instance.orderdate?.toIso8601String(),
      'totalprice': instance.totalprice,
      'userId': instance.userId,
      'orderHistoryStateList': instance.orderHistoryStateList,
    };
