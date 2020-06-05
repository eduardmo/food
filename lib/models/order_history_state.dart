import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_history_state.g.dart';

@JsonSerializable()
@immutable
class OrderHistoryState {
  final String name;
  final double price;
  final int quantity;
  final String image;

  OrderHistoryState({
    this.name,
    this.price,
    this.quantity,
    this.image});

  Map<String, dynamic> toJson() => _$OrderHistoryStateToJson(this);

  factory OrderHistoryState.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryStateFromJson(json);

  OrderHistoryState copyWith({
    final String name,
    final double price,
    final int quantity,
    final String image
    }) {
    return new OrderHistoryState(
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image);
  }

  @override
  String toString() {
    return "{name: $name}";
  }
}
