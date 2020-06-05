// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return UserState(
    name: json['name'] as String,
    email: json['email'] as String,
    balance: (json['balance'] as num).toDouble(),
    uid: json['uid'] as String,
    isAdmin: json['isAdmin'] as bool,
  );
}

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
      'balance': instance.balance,
      'isAdmin': instance.isAdmin,
    };
