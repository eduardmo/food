import 'package:flutter/material.dart';
import 'package:food/models/items_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_state.g.dart';

@JsonSerializable()
@immutable
class MenuState {
  final String id;
  final String Name;
  final String Address;
  final String Email;
  final String Phone;
  final String isActive;
  final ItemState item;
  final Map<dynamic, dynamic> requestedList;

  MenuState({this.id,
    this.Name,
    this.Address,
    this.Email,
    this.Phone,
    this.isActive,
    this.item,
    this.requestedList});

  Map<String, dynamic> toJson() => _$MenuStateToJson(this);

  factory MenuState.fromJson(Map<String, dynamic> json) =>
      _$MenuStateFromJson(json);

  MenuState copyWith({final ItemState item,
    final String Name,
    final Map<dynamic, dynamic> requestedList}) {
    return new MenuState(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Address: Address ?? this.Address,
        Email: Email ?? this.Email,
        Phone: Phone ?? this.Phone,
        isActive: isActive ?? this.isActive,
        item: item ?? this.item,
        requestedList: requestedList ?? this.requestedList);
  }

  @override
  String toString() {
    return "{Name: $Name,Address:$Address,Email:$Email,Phone:$Phone,isActive:$isActive,item: $item, requestedList: $requestedList}";
  }
}
