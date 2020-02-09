import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/containers/common.dart';
import 'package:food/containers/small_floating_button.dart';
import 'package:food/models/app_state.dart';
import 'package:redux/redux.dart';

List<Food> foodList = [
  Food(name: "Cereals",
      image: "1.jpg",
      price: 5.99),
  Food(name: "Massala",
  image: "3.jpg",
  price: 13.99),
  Food(name: "Taccos",
      image: "5.jpg",
      price: 3.72),
  Food(name: "Cereals",
      image: "1.jpg",
      price: 5.99),

];

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
       converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
    return Container(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vm.items.length,
          itemBuilder: (_, index) {
            String key = vm.items.keys.elementAt(index);
            Map<dynamic, dynamic> value = vm.items.values.elementAt(index);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: red[50],
                              offset: Offset(3, 8),
                              blurRadius: 15)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          value.values.elementAt(1),
                          width: 140,
                          height: 140,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(key),
                            ),
                            SmallButton(Icons.favorite)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "4.5",
                                    style: TextStyle(color: grey, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 14,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 14,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 14,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: red,
                                    size: 14,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: grey,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "(298)",
                                    style: TextStyle(color: grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                value.values.elementAt(0).toString(),
                                style: TextStyle(color: black, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
      }
    
    );
  }
}


  class _ViewModel {
  final Map<String, dynamic> items;
  
  _ViewModel({this.items});

  static _ViewModel fromStore(Store<AppState> store) {
  	// This is a bit of a more complex _viewModel
  	// constructor. As the state updates, it will
  	// recreate this _viewModel, and then pass
  	// buttonText and the callback down tolist(0) the button
  	// with the appropriate qualities:
  	//
    return new _ViewModel( 
        items: store.state.menu.item.items,
    );
  }
}


class Food{
  final String name;
  final String image;
  final double price;

  Food({this.name, this.image, this.price});


}