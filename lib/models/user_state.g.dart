// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserState _$UserStateFromJson(Map<String, dynamic> json) {
  return UserState(
    name: json['name'] as String,
    email: json['email'] as String,
    uid: json['uid'] as String,
    isAdmin: json['isAdmin'] as bool,
    adminMenus: (json['adminMenus'] as List)
        ?.map((e) =>
            e == null ? null : MenuState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    cartState: CartState.fromJson(json['cartState'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserStateToJson(UserState instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'uid': instance.uid,
      'isAdmin': instance.isAdmin,
      'cartState': instance.cartState,
      'adminMenus': instance.adminMenus,
    };
