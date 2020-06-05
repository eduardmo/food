import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food/actions/Admin/admin_master_order_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/master_order_state.dart';
import 'package:food/widget/datetimepicker.dart';
import 'package:redux/redux.dart';

class MasterOrderManagement extends StatelessWidget {
  final String pageTitle;

  MasterOrderManagement({Key key, this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          store.dispatch(retrieveAdminMasterOrders);
        },
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Orders Management",
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.left),
                  ),
                  ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true, // use it
                      children: vm.masterOrderStates.map((MasterOrderState e) {
                        return Card(
                            child: InkWell(
                                onTap: () {
                                  vm.onPressMenuDetail(e);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              Text(e.startDateTime.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              Text(" | ",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                              Text(e.endDateTime.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption),
                                            ],
                                          )
                                        ]))));
                      }).toList())
                ])),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                generateCreateMasterOrderFABDialog(context, vm);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          );
        });
  }
}

void generateCreateMasterOrderFABDialog(BuildContext context, _ViewModel vm) {
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
                    child: Text("Create Master Order",
                        style: Theme.of(context).textTheme.headline5)),
                Container(
                    height: 400,
                    child: AddMasterOrder(
                        onAddMasterBalanceFormSubmit:
                            vm.onAddMasterBalanceFormSubmit))
              ]),
            )));
      });
}

// Create a Form widget.
class AddMasterOrder extends StatefulWidget {
  final Function onAddMasterBalanceFormSubmit;
  AddMasterOrder({this.onAddMasterBalanceFormSubmit});

  @override
  AddMasterOrderState createState() {
    return AddMasterOrderState(
        onAddMasterBalanceFormSubmit: onAddMasterBalanceFormSubmit);
  }
}

class AddMasterOrderState extends State<AddMasterOrder> {
  final _formKey = GlobalKey<FormState>();
  final Function onAddMasterBalanceFormSubmit;
  bool _isEndDateTimeInvalid = false;
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now();

  AddMasterOrderState({this.onAddMasterBalanceFormSubmit});

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          DateTimePicker(
              labelText: "Select end datetime",
              selectedDate: _endDate,
              selectedTime: _endTime,
              selectDate: (DateTime r) => _endDate = r,
              selectTime: (TimeOfDay t) => _endTime = t),
          Visibility(
              visible: _isEndDateTimeInvalid,
              maintainSize: false,
              child: Text(
                "End datetime must be greater than now",
                style: TextStyle(color: Colors.redAccent),
              )),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                //Check End date valid
                DateTime endDate = new DateTime(_endDate.year, _endDate.month,
                    _endDate.day, _endTime.hour, _endTime.minute);
                //End date time less than now?
                if (endDate.compareTo(DateTime.now()) < 0) {
                  setState(() {
                    _isEndDateTimeInvalid = true;
                  });
                  return;
                }
                _formKey.currentState.save();
                this.onAddMasterBalanceFormSubmit(new MasterOrderState(
                    startDateTime: DateTime.now(), endDateTime: endDate));
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
  final Function onPressMenuDetail;
  final Function onAddMasterBalanceFormSubmit;
  final List<MasterOrderState> masterOrderStates;

  _ViewModel(
      {this.masterOrderStates,
      this.onAddMasterBalanceFormSubmit,
      this.onPressMenuDetail});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        onAddMasterBalanceFormSubmit: (MasterOrderState masterOrderState) {
          //Check no active order today
          List<MasterOrderState> masterOrderStateAfterNow = store
              .state.adminState.masterOrderStates
              .where((element) =>
                  element.endDateTime.compareTo(DateTime.now()) >= 0)
              .toList();
          if (masterOrderStateAfterNow.length > 0) {
            Fluttertoast.showToast(
              msg: "There is active Master Order already. Request canceled",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
            return; //Do not create a new one if an existing one exist
          }

          //Create Master order
          store.dispatch(saveNewMasterOrder(masterOrderState));
        },
        masterOrderStates: store.state.adminState.masterOrderStates ??
            new List<MasterOrderState>(),
        onPressMenuDetail: (MasterOrderState masterOrderState) {
          store.dispatch(
              NavigateToAction.push("/admin/masterorder/items", arguments: masterOrderState));
        });
  }
}
