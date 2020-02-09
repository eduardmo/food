import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/containers/categories.dart';
import 'package:food/containers/common.dart';
import 'package:food/containers/popular_food.dart';
import 'package:food/containers/small_floating_button.dart';
import 'package:food/models/app_state.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatelessWidget {

 @override
  Widget build(BuildContext context) {
  	// Connect tolist(0) the store:
    return StoreConnector<AppState, _ViewModel>(
 
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "What would you like tolist(0) eat?",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Stack(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.notifications_none), onPressed: () {
                       
                      }),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: red, borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: grey[300], offset: Offset(2, 1), blurRadius: 5)
                  ]),
              child: ListTile(
                leading: Icon(
                  Icons.search,
                  color: red,
                ),
                title: TextField(
                  decoration: InputDecoration(
                      hintText: "Find food or Restuarant",
                      border: InputBorder.none),
                ),
                trailing: Icon(
                  Icons.filter_list,
                  color: red,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Categories(),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Popular food",
              style: TextStyle(fontSize: 22, color: grey),
            ),
          ),
          Popular(),


//          End here
        ],
      )),
      bottomNavigationBar: Container(
        color: Color(0xFFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/home.png",
                width: 28,
                height: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/target.png",
                width: 28,
                height: 28,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/shopping-bag.png",
                width: 28,
                height: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/avatar.png",
                width: 28,
                height: 28,
              ),
            ),



          ],
        ),
      ),
    );  
      },
    );
  }
}

class _ViewModel {
  final Map<String, dynamic> items;
  
  _ViewModel({this.items});

  void initializeBestFood() {

  }

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

  