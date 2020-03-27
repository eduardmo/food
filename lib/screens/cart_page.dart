import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/cart_state.dart';
import 'package:food/models/items_state.dart';
import 'package:redux/redux.dart';

class CartPage extends StatefulWidget {
  _CartPage createState() => _CartPage();

}

class _CartPage extends State<CartPage> {

@override
Widget build(BuildContext context) {
  return new StoreConnector<AppState, _ViewModel> (
    converter: (Store<AppState> store) {
      return _ViewModel.fromStore(store);
    },
    builder: (BuildContext context, _ViewModel vm) {
      return new Scaffold(
        body: ListView.builder(
        itemCount: vm.cartState.itemState.length,
       itemBuilder: (context, index) {
         String name = vm.cartState.itemState[index].name;
         double price= vm.cartState.itemState[index].price;
        return GestureDetector(
        onTap:  () => {vm.emptyCart()},
        child: Dismissible(
          key: UniqueKey(),
          background: Container(
            alignment: AlignmentDirectional.centerEnd,
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            vm.deleteItem(vm.cartState.itemState[index]);
            print(vm.cartState.itemState[index]);
          },
          direction: DismissDirection.endToStart,
          child: Card(
              elevation: 5,
              child: Container(
              height: 100.0,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topLeft: Radius.circular(5)
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://is2-ssl.mzstatic.com/image/thumb/Video2/v4/e1/69/8b/e1698bc0-c23d-2424-40b7-527864c94a8e/pr_source.lsr/268x0w.png")
                      )
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                           
                            '$name'
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                               child: Container(
                              width: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: Text("$price",textAlign: TextAlign.center,),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                              child: Container(
                              width: 260,
                              child: Text("His genius finally recognized by his idol Chester",style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 48, 48, 54)
                              ),),
                              
                              
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
        );
      },
        ),
        bottomSheet: RaisedButton(
          onPressed: () => {vm.createOrder()},
          child: Text('Make order'),
          ),
      );
    },
  );
}
}


class _ViewModel {
  CartState cartState;
  final Function() emptyCart;
  final Function(ItemState state) deleteItem;
  final Function createOrder;
  _ViewModel({this.cartState, this.emptyCart, this.deleteItem(ItemState state), this.createOrder});
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      cartState: store.state.cartItems,
      emptyCart: () async  {
          store.dispatch(EmptyCart());
        },
      deleteItem: (ItemState state) async {
        store.dispatch(DeleteItem(state));
      },
      createOrder: () async{
        store.dispatch(CreateOrder(store.state.cartItems.itemState));
        await store.dispatch(createOrderMiddleware);
      }
    );
  }
}

