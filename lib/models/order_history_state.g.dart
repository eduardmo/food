// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryState _$OrderHistoryStateFromJson(Map<String, dynamic> json) {
  return OrderHistoryState(
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    quantity: json['quantity'] as int,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$OrderHistoryStateToJson(OrderHistoryState instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'image': instance.image,
    };
