import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/containers/network_image.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/cart_state.dart';
import 'package:food/models/items_state.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';

class OrderPage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile2.dart";
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
           return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade300, Colors.indigo.shade500]
              ),
            ),
          ),
          ListView.builder(
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
                if(index==0) return _buildHeader(context, vm);
    if(index==1) return _buildSectionHeader(context, vm);
    if(index==2) return _buildCollectionsRow(vm, index);
    return _buildListItem();
            },
          ),
        ],
      ),
    );
        });
  }

  Widget _buildListItem() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: PNetworkImage("images[2]", fit: BoxFit.cover),
      ),
    );
  }

  Container _buildSectionHeader(BuildContext context, _ViewModel vm) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("Order history", style: Theme.of(context).textTheme.title,),
          FlatButton(
            onPressed:() {},
            child: Text("See all history", style: TextStyle(color: Colors.blue),),
          )
        ],
      ),
    );
  }

  Container _buildCollectionsRow(_ViewModel vm, int index) {
    return Container(
      color: Colors.white,
      height: 200.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            width: 150.0,
            height: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: PNetworkImage("vm.oders", fit: BoxFit.cover))
                ),
                SizedBox(height: 5.0,),
                GestureDetector(
                  onTap: () {
                       vm.oders();
                  },
                  child: Text("{vm.oders}", style: Theme.of(context).textTheme.subhead.merge(TextStyle(color: Colors.grey.shade600))),
                )
              ],
            )
          );
        },
      ),
    );
  }

  Container _buildHeader(BuildContext context, _ViewModel vm) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0,),
                  Text("${vm.userState.name}", style: Theme.of(context).textTheme.title,),
                  SizedBox(height: 5.0,),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text("302",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text("Orders".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0) ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("10.3K",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text("Amount available".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0) ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("120",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text("Something else?".toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0) ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: CachedNetworkImageProvider("avatars[0]"),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewModel { 
  final UserState userState;
  final Function oders;
  _ViewModel({
    this.oders,
    this.userState,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      userState: store.state.user,
      oders: () async {
       await store.dispatch(retieveOrderMiddleware);
      }
    );
  }
}