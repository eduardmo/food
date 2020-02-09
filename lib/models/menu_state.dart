import 'package:flutter/material.dart';
import 'package:food/models/items_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_state.g.dart';

@JsonSerializable()
@immutable
class MenuState {
final ItemState item;
final String menuName;

MenuState({this.item, this.menuName});

Map<String, dynamic> toJson() => _$MenuStateToJson(this);

factory MenuState.fromJson(Map<String, dynamic> json) => _$MenuStateFromJson(json);


 @override
  String toString() {
    return "{MenuName: $menuName, items: $item}";
  }
}