import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items_state.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class ItemState{
final Map<String, dynamic> items;

ItemState(
  {this.items});

Map<String, dynamic> toJson() => _$ItemStateToJson(this);

factory ItemState.fromJson(Map<String, dynamic> json) => _$ItemStateFromJson(json);


 @override
  String toString() {
     return '$items'
    ;
  }
}