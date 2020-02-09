// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemState _$ItemStateFromJson(Map<String, dynamic> json) {
  return ItemState(
    name: json['name'] as String,
    price: json['price'] as int,
  );
}

Map<String, dynamic> _$ItemStateToJson(ItemState instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
