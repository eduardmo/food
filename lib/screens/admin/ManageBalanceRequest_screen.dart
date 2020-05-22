import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/Admin/admin_users_action.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:food/models/user_state.dart';
import 'package:redux/redux.dart';
import 'package:food/models/app_state.dart';

class ManageBalanceRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
              body: Container(
            child: generateTopUpRequestWidget(context, vm),
          ));
        });
  }
}

ListView generateTopUpRequestWidget(context, _ViewModel vm) {
  return ListView(
      padding: const EdgeInsets.all(8),
      children: List.generate(vm.topUpRequest.length, (index) {
        UserState userState = vm.userState
            .where((element) => element.uid == vm.topUpRequest[index].userid)
            .first;
        return Card(
            child: InkWell(
                onTap: generateApproveBalanceDialog(
                    context, vm, vm.topUpRequest[index], userState),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    CachedNetworkImage(
                        imageUrl: vm.topUpRequest[index].image, height: 30),
                    Container(height: 1, width: 8),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(" + €" +
                              vm.topUpRequest[index].balance.toString()),
                          Row(
                            children: <Widget>[
                              Text(userState.name),
                              Text(" "),
                              Text(vm.topUpRequest[index].dateTime.toString())
                            ],
                          )
                        ])
                  ]),
                )));
      }));
}

Function generateApproveBalanceDialog(BuildContext context, _ViewModel vm,
    TopUpRequestState topUpRequestState, UserState userState) {
  return () => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Padding(
                padding: EdgeInsets.all(8.0),
                child: Dialog(
                    child: Container(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Text("Approve Request",
                            style: Theme.of(context).textTheme.headline5),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("User: " + userState.name)),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Email: " + userState.email)),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Requested Balance: +€" +
                                topUpRequestState.balance.toString())),
                        CachedNetworkImage(
                            imageUrl: topUpRequestState.image, height: 350),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.of(context).pop()),
                            RaisedButton(
                                child: Text("Reject"),
                                onPressed: () {
                                  vm.onBalanceApproval(
                                      topUpRequestState, userState, false);
                                  Navigator.of(context).pop();
                                }),
                            RaisedButton(
                                child: Text("Approve"),
                                onPressed: () {
                                  vm.onBalanceApproval(
                                      topUpRequestState, userState, true);
                                  Navigator.of(context).pop();
                                })
                          ],
                        )
                      ])),
                )));
          },
        )
      };
}

class _ViewModel {
  final List<TopUpRequestState> topUpRequest;
  final List<UserState> userState;
  final Function onBalanceApproval;

  _ViewModel({this.topUpRequest, this.userState, this.onBalanceApproval});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        topUpRequest: (() {
          List topUpRequest = store.state.adminState.topUpRequestStates
              .where((element) => element.completed == false)
              .toList();

          //Sort by date
          topUpRequest.sort((a, b) {
            return b.dateTime.compareTo(a.dateTime);
          });

          return topUpRequest.toList();
        })(),
        userState: store.state.adminState.users,
        onBalanceApproval: (TopUpRequestState topUpRequestState,
            UserState userState, bool approval) {
          store.dispatch(submitBalanceApproval(
              topUpRequestState.copyWith(approved: approval, completed: true),
              userState));
        });
  }
}
