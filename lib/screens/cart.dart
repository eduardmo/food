import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/master_order_action.dart';
import 'package:food/actions/order_history_action.dart';
import 'package:food/containers/network_image.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';

class CartOnePage extends StatelessWidget {
  static final String path = "lib/src/pages/ecommerce/cart1.dart";
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 30.0),
                      child: Text(
                        "CART",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700),
                      )),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: vm.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              margin:
                                  EdgeInsets.only(right: 30.0, bottom: 10.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(5.0),
                                elevation: 3.0,
                                child: Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 80,
                                        child:
                                            PNetworkImage(vm.cart[index].image),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("${vm.cart[index].name}"),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              "${vm.cart[index].price}€",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 15,
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  padding: EdgeInsets.all(0.0),
                                  color: Color.fromRGBO(128, 185, 38, 100),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    vm.deleteItem(vm.cart[index]);
                                  },
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          (() {
                            //Get Subtotal
                            double totalPrice = 0;
                            for (int x = 0; x < vm.cart.length; x++) {
                              totalPrice += vm.cart[x].price;
                            }
                            return "Cart Total Price :$totalPrice";
                          })(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            height: 50.0,
                            color: Color.fromRGBO(128, 185, 38, 100),
                            child: Text(
                              "Secure Checkout".toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              vm.createOrder();
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _ViewModel {
  final List<ItemState> cart;
  final Function(ItemState state) deleteItem;
  final Function createOrder;
  _ViewModel({
    this.createOrder,
    this.deleteItem,
    this.cart,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        cart: store.state.cart,
        deleteItem: (ItemState state) async {
          store.dispatch(DeleteItem(state));
        },
        createOrder: () async{
          //Retrieve master order
          await store.dispatch(retrieveMasterOrders);

          //Save order
          store.dispatch(createOrderHistory());
        });
  }
}
