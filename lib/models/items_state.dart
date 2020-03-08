import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items_state.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class ItemState {
  final String id;
  final String categoryId;
  final String image;
  final String menuId;
  final String name;
  final double price;

  ItemState(
      {this.id,
      this.categoryId,
      this.image,
      this.menuId,
      this.name,
      this.price
      });

  Map<String, dynamic> toJson() => _$ItemStateToJson(this);

  factory ItemState.fromJson(Map<String, dynamic> json) =>
      _$ItemStateFromJson(json);

  @override
  String toString() {
    return 'id: $id, Name: $name';
  }
}
