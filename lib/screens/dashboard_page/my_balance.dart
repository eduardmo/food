import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:food/models/balance_history_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
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
              return Dialog(
                child: Column(children: [
                  Text("Add Balance"),
                ]),
              );
            })
      };
}

// Create a Form widget.
class AddBalance extends StatefulWidget {
  @override
  AddBalanceState createState() {
    return AddBalanceState();
  }
}

class _AddBalanceData {
  String balance = "";
  String image = "";
}

class AddBalanceState extends State<AddBalance> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.number,
            validator: (value) {
              return int.parse(value) < 10 ? "Please input price" : null;
            },
            decoration: InputDecoration(hintText: "Price (min €10)"),
            onSaved: (value) {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  //final Function onPressAddMenu;
  //final Function onPressMenuDetail;

  final List<BalanceHistoryState> balanceHistory;
  final List<TopUpRequestState> topUpRequest;

  _ViewModel({this.balanceHistory, this.topUpRequest});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        balanceHistory: store.state.balanceHistory,
        topUpRequest: store.state.topUpRequest);
  }
}
