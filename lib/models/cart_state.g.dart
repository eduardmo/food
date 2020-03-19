// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartState _$CartStateFromJson(Map<String, dynamic> json) {
  return CartState(
    itemState: (json['itemState'] as List)
        ?.map((e) =>
            e == null ? null : ItemState.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CartStateToJson(CartState instance) => <String, dynamic>{
      'itemState': instance.itemState,
    };
