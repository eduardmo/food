// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemState _$ItemStateFromJson(Map<String, dynamic> json) {
  return ItemState(
    id: json['id'] as String,
    categoryId: json['categoryId'] as String,
    image: json['image'] as String,
    menuId: json['menuId'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ItemStateToJson(ItemState instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'image': instance.image,
      'menuId': instance.menuId,
      'name': instance.name,
      'price': instance.price,
    };
