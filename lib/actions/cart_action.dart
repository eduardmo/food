import 'package:food/models/items_state.dart';

class RequestCartState {
  List<ItemState> item;

  RequestCartState(List<ItemState> item);

  @override
  String toString() {
    return 'CartState{cart: $item}';
  }
}

class AddToCart {
  ItemState order;

  AddToCart(this.order);

  @override
  String toString() {
    return 'AddToCart{item: $order}';
  }
}

class EmptyCart {
  @override
  String toString() {
    return 'EmptyCart{}';
  }
}

class DeleteItem {
  ItemState cartItem;

  DeleteItem(this.cartItem);

  @override
  String toString() {
    return 'DeleteItem{item: $cartItem}';
  }
}

