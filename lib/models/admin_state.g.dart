// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminState _$AdminStateFromJson(Map<String, dynamic> json) {
  return AdminState(
    users: (json['users'] as List)
        ?.map((e) =>
            e == null ? null : UserState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    menus: (json['menus'] as List)
        ?.map((e) =>
            e == null ? null : MenuState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    topUpRequestStates: (json['topUpRequestStates'] as List)
        ?.map((e) => e == null
            ? null
            : TopUpRequestState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AdminStateToJson(AdminState instance) =>
    <String, dynamic>{
      'users': instance.users,
      'menus': instance.menus,
      'topUpRequestStates': instance.topUpRequestStates,
    };
