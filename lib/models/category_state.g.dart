// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryState _$CategoryStateFromJson(Map<String, dynamic> json) {
  return CategoryState(
    id: json['id'] as String,
    categoryName: json['categoryName'] as String,
    image: json['image'] as String,
    menuId: json['menuId'] as String,
    isActive: json['isActive'] as bool,
  );
}

Map<String, dynamic> _$CategoryStateToJson(CategoryState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'image': instance.image,
      'menuId': instance.menuId,
      'isActive': instance.isActive,
    };
