import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:food/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MyBalance extends StatelessWidget {
  bool isAdmin = false;
  Function onAdminButtonClicked;
  Function onUserProfileClicked;
  Function onLogoutClicked;

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return DefaultTabController(
              // Added
              length: tabChoises.length, // Added
              initialIndex: 0, //Added
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('My Balance'),
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: tabChoises.map((String choice) {
                      return Tab(
                        text: choice,
                      );
                    }).toList(),
                  ),
                ),
                body: TabBarView(
                  children: tabChoises.map((String choice) {
                    return TabChooser(choice: choice, vm: vm);
                  }).toList(),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: generateAddBalanceFABDialog(context, vm),
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                ),
              ));
        });
  }
}

const List<String> tabChoises = const <String>[
  'Balance Request',
  'Balance History'
];

class TabChooser extends StatelessWidget {
  const TabChooser({Key key, this.choice, this.vm}) : super(key: key);
  final String choice;
  final _ViewModel vm;

  @override
  Widget build(BuildContext context) {
    switch (choice) {
      case "Balance Request":
        return generateTopUpRequestWidget(vm);
      case "Balance History":
        return generateBalanceHistoryWidget(vm);
    }
    return Text("Error building widget");
  }
}

ListView generateBalanceHistoryWidget(_ViewModel vm) {
  return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(vm.balanceHistory.length, (index) {
        String type = "";
        if (vm.balanceHistory[index].type == "PLUS")
          type = "+";
        else
          type = "-";

        return Card(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(type + " €" + vm.balanceHistory[index].balance.toString()),
            Text(vm.balanceHistory[index].dateTime.toString())
          ]),
        ));
      }));
}

ListView generateTopUpRequestWidget(_ViewModel vm) {
  return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(vm.topUpRequest.length, (index) {
        String approvalStatus = "Reviewing request";
        if (vm.topUpRequest[index].completed &&
            vm.topUpRequest[index].approved) {
          approvalStatus = "Approved";
        } else if (vm.topUpRequest[index].completed &&
            !vm.topUpRequest[index].approved) {
          approvalStatus = "rejected";
        }

        return Card(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(" €" + vm.topUpRequest[index].balance.toString()),
            Row(
              children: <Widget>[
                Text(vm.topUpRequest[index].dateTime.toString()),
                Text(" "),
                Text(approvalStatus)
              ],
            )
          ]),
        ));
      }));
}

Function generateAddBalanceFABDialog(BuildContext context, _ViewModel vm) {
  return () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Dialog(
                      child: Container(
                    height: 450,
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Add Balance Request",
                              style: Theme.of(context).textTheme.headline)),
                      Container(
                          height: 400,
                          child: AddBalance(
                              onTopUpRequestFormSubmit:
                                  vm.onTopUpRequestFormSubmit,
                              userid: vm.userid))
                    ]),
                  )));
            })
      };
}

// Create a Form widget.
class AddBalance extends StatefulWidget {
  final Function onTopUpRequestFormSubmit;
  final String userid;
  AddBalance({this.onTopUpRequestFormSubmit, this.userid});

  @override
  AddBalanceState createState() {
    return AddBalanceState(
        onTopUpRequestFormSubmit: onTopUpRequestFormSubmit, userid: userid);
  }
}

class AddBalanceState extends State<AddBalance> {
  final _formKey = GlobalKey<FormState>();
  final Function onTopUpRequestFormSubmit;
  final String userid;
  
  bool _isformEdit = false;
  bool _isFileUploadValidationFailed = false;
  double _balance;
  File _image;

  AddBalanceState({this.onTopUpRequestFormSubmit, this.userid});

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              try {
                if (double.parse(value) < 10) throw "";
                return null;
              } catch (e) {
                return "Please input price";
              }
            },
            decoration: InputDecoration(hintText: "Price (min €10)"),
            onTap: (){
              setState((){
                _isformEdit = true;
              });
            },
            onEditingComplete: (){
              setState((){
                _isformEdit = false;
              });
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            onChanged: (value) {
              _balance = double.parse(value);
            },
          ),
          Column(children: [
            RaisedButton(
              onPressed: _isformEdit==true?null:()=>getImage(),
              child: Text('Input Receipt'),
            ),
            Visibility(
                visible: _isFileUploadValidationFailed,
                maintainSize: false,
                child: Text(
                  "Please Input Receipt",
                  style: TextStyle(color: Colors.redAccent),
                )),
            _image == null
                ? new Container(
                    height: 0,
                  )
                : Image.file(
                    _image,
                    height: 200,
                    width: 300,
                  ),
          ]),
          RaisedButton(
            onPressed: _isformEdit==true?null:() {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                
                //check Image Exist
                if(_image == null){
                  setState(() {
                    _isFileUploadValidationFailed = true;
                  });
                  return;
                }
                _formKey.currentState.save();
                this.onTopUpRequestFormSubmit(new TopUpRequestState(
                    balance: _balance,
                    approved: false,
                    image: _image.path,
                    completed: false,
                    dateTime: DateTime.now(),
                    userid: userid));
                    Navigator.of(context).pop(); 
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final Function onTopUpRequestFormSubmit;
  final String userid;

  final List<BalanceHistoryState> balanceHistory;
  final List<TopUpRequestState> topUpRequest;

  _ViewModel(
      {this.userid,
      this.balanceHistory,
      this.topUpRequest,
      this.onTopUpRequestFormSubmit});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        userid: store.state.user.uid,
        balanceHistory: store.state.balanceHistory,
        topUpRequest: store.state.topUpRequest,
        onTopUpRequestFormSubmit: (TopUpRequestState topUpRequestState) =>
            {print(topUpRequestState.userid)});
  }
}
