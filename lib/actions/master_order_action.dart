import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/master_order_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class RequestMasterOrders {
  final MasterOrderState masterOrderStates;

  RequestMasterOrders(this.masterOrderStates);

  @override
  String toString() {
    return 'RequestMasterOrders';
  }
}

ThunkAction<AppState> retrieveMasterOrders = (Store<AppState> store) async {
  try {
    //Get all Master menu
    List<MasterOrderState> masterOrderStates = await Firestore.instance
        .collection("MasterOrder")
        .where("endDateTime",isGreaterThan: DateTime.now())
        .getDocuments()
        .then((QuerySnapshot query) async {
      return query.documents.map((DocumentSnapshot e){
        return new MasterOrderState(
          id: e.documentID,
          startDateTime: e.data["startDateTime"].toDate(),
          endDateTime: e.data["endDateTime"].toDate()
        );
      }).toList();
    }).catchError((error) => {print(error)});

    if(masterOrderStates.length > 0){    
      store.dispatch(RequestMasterOrders(masterOrderStates.last));
    }else{
      RequestMasterOrders(new MasterOrderState(id:null));
    }

  } catch (error) {
    print(error);
  }
};