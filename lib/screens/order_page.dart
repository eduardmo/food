import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/cart_action.dart';
import 'package:food/actions/mybalance_action.dart';
import 'package:food/containers/network_image.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:food/models/user_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

class OrderPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.indigo.shade300,
                      Colors.indigo.shade500
                    ]),
                  ),
                ),
                ListView.builder(
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) return _buildHeader(context, vm);
                    if (index == 1)
                      return _buildSectionHeader(
                          "Order History", "See all history", context, vm);
                    if (index == 2) return _buildCollectionsRow(vm, index);
                    if (index == 3)
                      return _buildSectionHeader(
                          "Top up history", "See all history", context, vm);
                     return _buildListItem(index, vm);
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                buildTopUpDialog(context, vm);
              },
              child: Text(
                "Top up",
                style: GoogleFonts.lato(),
              ),
              backgroundColor: Colors.green,
            ),
          );
        });
  }

  Widget buildTopUpDialog(BuildContext context, _ViewModel vm) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
              child: Dialog(
            elevation: 9,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(right: 16.0),
              height: 1000,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75),
                      bottomLeft: Radius.circular(75),
                      topRight: Radius.circular(75),
                      bottomRight: Radius.circular(75))),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Image(
                              width: 150,
                              image: AssetImage('images/money.png'),
                            ),
                          ),
                        ),
                        Text(
                          "Top up",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 10.0),
                        Flexible(
                          child: Text("How much do you want to top up with?"),
                        ),
                        SizedBox(height: 10.0),
                        FormBuilder(
                          key: _fbKey,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                attribute: "topUpValue",
                                // onChanged: _onChanged,
                                valueTransformer: (text) {
                                  return text == null
                                      ? null
                                      : num.tryParse(text);
                                },
                                validators: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.numeric(),
                                  FormBuilderValidators.min(10),
                                ],
                                keyboardType: TextInputType.number,
                              ),
                              FormBuilderImagePicker(
                                attribute: "images",
                                decoration: InputDecoration(
                                  labelText:
                                      "Add a screenshot with the request",
                                ),
                                iconColor: Colors.red,
                                // readOnly: true,
                                validators: [
                                  FormBuilderValidators.required(),
                                ],
                              ),
                              FormBuilderSignaturePad(
                                decoration:
                                    InputDecoration(labelText: "Signature"),
                                attribute: "signature",
                                height: 100,
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Expanded(
                              child: RaisedButton(
                                child: Text("Cancel"),
                                color: Colors.red,
                                colorBrightness: Brightness.dark,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: RaisedButton(
                                child: Text("Submit"),
                                color: Colors.green,
                                colorBrightness: Brightness.dark,
                                onPressed: () {
                                  {
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      int topUpValue = _fbKey
                                          .currentState.value['topUpValue'];
                                      File image = _fbKey
                                          .currentState.value['images'][0];

                                      print(image.path.substring(6));
                                      try {
                                        vm.onTopUpRequestFormSubmit(
                                            new TopUpRequestState(
                                                balance: topUpValue.toDouble(),
                                                approved: false,
                                                image: image.path,
                                                completed: false,
                                                dateTime: DateTime.now(),
                                                userid: vm.userState.uid));
                                        Navigator.pop(context);
                                      } catch (error) {
                                        print(error);
                                      }
                                    } else {
                                      print(_fbKey.currentState
                                          .value['contact_person'].runtimeType);
                                      print(_fbKey.currentState.value);
                                      print("validation failed");
                                    }
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  Widget _buildListItem(int index, _ViewModel vm) {
    return Container(
      color: Colors.white,
      height: 130.0,
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.white,
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 5.0,
              color: vm.topUpRequest.reversed.toList()[index-4].approved == true && vm.topUpRequest.reversed.toList()[index-4].completed == true ? Colors.green.shade100 
              : (vm.topUpRequest.reversed.toList()[index-4].approved == false && vm.topUpRequest.reversed.toList()[index-4].completed == true ? Colors.red.shade100 : Colors.yellow.shade100 ) ,
              child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: Icon(Icons.attach_money, color: Colors.black),
                  ),
                  title: Text(
                    "You topped up with: ${vm.topUpRequest.reversed.toList()[index-4].balance}€",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Tsext("Intermediate", style: TextStyle(color: Colors.white)),

                  subtitle: Row(
                    children: <Widget>[
                      Text("${vm.topUpRequest.reversed.toList()[index-4].dateTime}",
                          style: TextStyle(color: Colors.black)
                          )
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.black, size: 30.0)),
            ),
          )
        ],
      ),
    );
  }

  Container _buildSectionHeader(String firstText, String secondsText,
      BuildContext context, _ViewModel vm) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$firstText",
            style: Theme.of(context).textTheme.headline6,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "$secondsText",
              style: TextStyle(color: Colors.blue),
            ),
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
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            width: 150.0,
            height: 200.0,
            child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                elevation: 5.0,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child:
                                PNetworkImage("vm.oders", fit: BoxFit.cover))),
                    SizedBox(
                      height: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        vm.oders();
                      },
                      child: Text("{vm.oders}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .merge(TextStyle(color: Colors.grey.shade600))),
                    )
                  ],
                )),
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
            padding: EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "${vm.userState.name}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "302",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Orders".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "10.3K",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Amount available".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "120",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Something else?".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0)),
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
                  backgroundImage: CachedNetworkImageProvider("avatars[0]"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final Function onTopUpRequestFormSubmit;
  final Function oders;

  final List<BalanceHistoryState> balanceHistory;
  final UserState userState;
  final List<TopUpRequestState> topUpRequest;

  _ViewModel({
    this.balanceHistory,
    this.onTopUpRequestFormSubmit,
    this.topUpRequest,
    this.oders,
    this.userState,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      userState: store.state.user,
      oders: () async {
        await store.dispatch(retieveOrderMiddleware);
      },
      topUpRequest: store.state.topUpRequest,
      onTopUpRequestFormSubmit: (TopUpRequestState topUpRequestState) =>
          {store.dispatch(submitTopUpRequest(topUpRequestState))},

      balanceHistory: store.state.balanceHistory,
    );
  }
}
