// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuState _$MenuStateFromJson(Map<String, dynamic> json) {
  return MenuState(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    isActive: json['isActive'] as bool,
    requestedList: json['requestedList'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$MenuStateToJson(MenuState instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'email': instance.email,
      'phone': instance.phone,
      'isActive': instance.isActive,
      'requestedList': instance.requestedList,
    };
