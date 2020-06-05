// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_order_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterOrderState _$MasterOrderStateFromJson(Map<String, dynamic> json) {
  return MasterOrderState(
    id: json['id'] as String,
    orderHistoryHeaderState: (json['orderHistoryHeaderState'] as List)
        ?.map((e) => e == null
            ? null
            : OrderHistoryHeaderState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    startDateTime: json['startDateTime'] == null
        ? null
        : DateTime.parse(json['startDateTime'] as String),
    endDateTime: json['endDateTime'] == null
        ? null
        : DateTime.parse(json['endDateTime'] as String),
  );
}

Map<String, dynamic> _$MasterOrderStateToJson(MasterOrderState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDateTime': instance.startDateTime?.toIso8601String(),
      'endDateTime': instance.endDateTime?.toIso8601String(),
      'orderHistoryHeaderState': instance.orderHistoryHeaderState,
    };
