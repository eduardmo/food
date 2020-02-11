// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuState _$MenuStateFromJson(Map<String, dynamic> json) {
  return MenuState(
    item: json['item'] == null
        ? null
        : ItemState.fromJson(json['item'] as Map<String, dynamic>),
    menuName: json['menuName'] as String,
    requestedList: json['requestedList'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$MenuStateToJson(MenuState instance) => <String, dynamic>{
      'item': instance.item,
      'menuName': instance.menuName,
      'requestedList': instance.requestedList,
    };
