// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topup_request_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopUpRequestState _$TopUpRequestStateFromJson(Map<String, dynamic> json) {
  return TopUpRequestState(
    id: json['id'] as String,
    balance: (json['balance'] as num)?.toDouble(),
    image: json['image'] as String,
    approved: json['approved'] as bool,
    completed: json['completed'] as bool,
    userid: json['userid'] as String,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
  );
}

Map<String, dynamic> _$TopUpRequestStateToJson(TopUpRequestState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'image': instance.image,
      'approved': instance.approved,
      'completed': instance.completed,
      'userid': instance.userid,
      'dateTime': instance.dateTime?.toIso8601String(),
    };
