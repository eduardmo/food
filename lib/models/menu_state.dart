import 'package:flutter/material.dart';
import 'package:food/models/items_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_state.g.dart';

@JsonSerializable()
@immutable
class MenuState {
  final String id;
  final String name;
  final String address;
  final String email;
  final String phone;
  final bool isActive;

  @JsonKey(nullable: true, includeIfNull: true)
  final Map<dynamic, dynamic> requestedList;

  MenuState({this.id,
    this.name,
    this.address,
    this.email,
    this.phone,
    this.isActive,
    this.requestedList});

  Map<String, dynamic> toJson() => _$MenuStateToJson(this);

  factory MenuState.fromJson(Map<String, dynamic> json) =>
      _$MenuStateFromJson(json);

  MenuState copyWith({final ItemState item,
    final String name,
    final Map<dynamic, dynamic> requestedList}) {
    return new MenuState(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        isActive: isActive ?? this.isActive,
        requestedList: requestedList ?? this.requestedList);
  }

  @override
  String toString() {
    return "{name: $name,address:$address,email:$email,phone:$phone,isActive:$isActive, requestedList: $requestedList}";
  }
}
