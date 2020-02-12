import 'package:flutter/material.dart';
import 'package:food/models/items_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_state.g.dart';

@JsonSerializable()
@immutable
class MenuState {
final ItemState item;
final String menuName;
final Map<dynamic, dynamic> requestedList;

MenuState({this.item, this.menuName, this.requestedList});

Map<String, dynamic> toJson() => _$MenuStateToJson(this);

factory MenuState.fromJson(Map<String, dynamic> json) => _$MenuStateFromJson(json);

MenuState copyWith({
  final ItemState item,
  final String menuName,
  final Map<dynamic, dynamic> requestedList
  }) {
    return new MenuState(
      menuName: menuName ?? this.menuName,
      item: item ?? this.item,
      requestedList: requestedList ?? this.requestedList
    );
  }
  
 @override
  String toString() {
    return "{MenuName: $menuName, items: $item, requestedList: $requestedList}";
  }
}