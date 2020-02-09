import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items_state.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class ItemState{
final String name;
final int price;

ItemState(
  {this.name, 
this.price});

Map<String, dynamic> toJson() => _$ItemStateToJson(this);

factory ItemState.fromJson(Map<String, dynamic> json) => _$ItemStateFromJson(json);


 @override
  String toString() {
     return '''AppState{
      ItemName: $name,
      price: $price,
    }''';
  }
}