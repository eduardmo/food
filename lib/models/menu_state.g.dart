// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuState _$MenuStateFromJson(Map<String, dynamic> json) {
  return MenuState(
    id: json['id'] as String,
    Name: json['Name'] as String,
    Address: json['Address'] as String,
    Email: json['Email'] as String,
    Phone: json['Phone'] as String,
    isActive: json['isActive'] as bool,
    item: json['item'] == null
        ? null
        : ItemState.fromJson(json['item'] as Map<String, dynamic>),
    requestedList: json['requestedList'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$MenuStateToJson(MenuState instance) => <String, dynamic>{
  'id': instance.id,
  'Name': instance.Name,
  'Address': instance.Address,
  'Email': instance.Email,
  'Phone': instance.Phone,
  'isActive': instance.isActive,
      'item': instance.item,
      'requestedList': instance.requestedList,
    };
