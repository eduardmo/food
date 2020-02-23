import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/containers/buttons.dart';
import 'package:food/models/app_state.dart';
import 'package:food/styles/colors.dart';
import 'package:food/styles/styles.dart';
import 'package:redux/redux.dart';

class ProductPage extends StatefulWidget {
  final String productName;

  ProductPage(this.productName);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double _rating = 4;
  int _quantity = 1;

  String get productName => widget.productName;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              backgroundColor: bgColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: bgColor,
                centerTitle: true,
                leading: BackButton(
                  color: darkText,
                  onPressed: vm.popPage,
                ),
                title: Text(productName),
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.only(top: 100, bottom: 100),
                              padding: EdgeInsets.only(top: 100, bottom: 50),
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(productName),
                                  Text('sal'),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 20),
                                    // child: SmoothStarRating(
                                    //   allowHalfRating: false,
                                    //   onRatingChanged: (v) {
                                    //     setState(() {
                                    //       _rating = v;
                                    //     });
                                    //   },
                                    //   starCount: 5,
                                    //   rating: _rating,
                                    //   size: 27.0,
                                    //   color: Colors.orange,
                                    //   borderColor: Colors.orange,
                                    // ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 25),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text('Quantity', style: h6),
                                          margin: EdgeInsets.only(bottom: 15),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 55,
                                              height: 55,
                                              child: OutlineButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _quantity += 1;
                                                  });
                                                },
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(_quantity.toString(),
                                                  style: h3),
                                            ),
                                            Container(
                                              width: 55,
                                              height: 55,
                                              child: OutlineButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_quantity == 1) return;
                                                    _quantity -= 1;
                                                  });
                                                },
                                                child: Icon(Icons.remove),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 180,
                                    child: froyoOutlineBtn('Buy Now', () {}),
                                  ),
                                  Container(
                                    width: 180,
                                    child: froyoFlatBtn('Add to Cart', () {}),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 15,
                                        spreadRadius: 5,
                                        color: Color.fromRGBO(0, 0, 0, .05))
                                  ]),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 200,
                              height: 160,
                              // child: foodItem(widget.productData,
                              //     isProductPage: true,
                              //     onTapped: () {},
                              //     imgWidth: 250,
                              //     onLike: () {}),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }
}

class _ViewModel {
  final Map<String, dynamic> items;
  final Map<dynamic, dynamic> requestedItems;
  final Function() popPage;

  _ViewModel({this.items, this.requestedItems, this.popPage});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        items: store.state.menu.item.items,
        requestedItems: store.state.menu.requestedList,
        popPage: () async {
          store.dispatch(NavigateToAction.pop());
        });
  }
}
