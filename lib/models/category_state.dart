import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable/builder.dart';

part 'category_state.g.dart';

@JsonSerializable()
@immutable
class CategoryState {
  final String id;
  final String categoryName;
  final String image;
  final String menuId;
  final bool isActive;

  CategoryState({this.id, this.categoryName, this.image, this.menuId, this.isActive});

  Map<String, dynamic> toJson() => _$CategoryStateToJson(this);

  factory CategoryState.fromJson(Map<String, dynamic> json) =>
      _$CategoryStateFromJson(json);

  CategoryState copyWith(
      {final String id,
      final String categoryName,
      final String image,
      final String menuId,
      final bool isActive}) {
    return new CategoryState(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        image: image ?? this.image,
        menuId: menuId ?? this.menuId,
        isActive: isActive ?? this.isActive);
  }

  @override
  String toString() {
    return "{id: $id,categoryName:$categoryName,image:$image,menuId:$menuId, isActive: $isActive}";
  }
}
