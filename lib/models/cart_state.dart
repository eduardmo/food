import 'package:flutter/material.dart';
import 'package:food/models/items_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_state.g.dart';

@JsonSerializable(nullable: true)
class CartState {
@JsonKey(nullable: true, includeIfNull: true)
final List<ItemState> itemState;

CartState({List<ItemState> itemState}) : itemState = null ?? new List<ItemState>();

Map<String, dynamic> toJson() => _$CartStateToJson(this);

factory CartState.fromJson(Map<String, dynamic> json) =>_$CartStateFromJson(json);

CartState copyWith(
      {final List<ItemState> itemState}) {
    return new CartState(
        itemState: itemState ?? this.itemState);
  }

  @override
  String toString() {
    return "{itemState: $itemState}";
  }
}