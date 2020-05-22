import 'package:food/models/items_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_state.g.dart';

@JsonSerializable(nullable: true)
class CartState {
@JsonKey(nullable: true, includeIfNull: true)
final List<ItemState> itemState;
@JsonKey(nullable: true, includeIfNull: true)
final List<ItemState> order;
@JsonKey(nullable: true, includeIfNull: true)
final String image;

CartState({this.itemState, this.order, this.image});

Map<String, dynamic> toJson() => _$CartStateToJson(this);

factory CartState.fromJson(Map<String, dynamic> json) =>_$CartStateFromJson(json);

CartState copyWith({
  final List<ItemState> itemState,
  final List<ItemState> order,
  final String image,
  }) {
    return new CartState(
        itemState: itemState ?? this.itemState,
        order: order ?? this.order,
        image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return "{cartState: $itemState, order: $order, image: $image}";
  }
}