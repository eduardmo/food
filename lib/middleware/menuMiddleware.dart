import 'package:food/models/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ThunkAction<AppState> exampleEpic = (Store<AppState> store) async {
      try {

       var querySnapshot = await Firestore.instance.collection("Menu").where('isActive', isEqualTo: true).getDocuments();

       var data = querySnapshot.documents.map((DocumentSnapshot doc) {
         return doc.data;
       });
       String documentId;
       var itemQuery = querySnapshot.documents.map((DocumentSnapshot doc) {
         return doc.data['Items'].forEach( ( documentReference) async =>  await documentReference.get().then((DocumentSnapshot documentSnapshot) {
           documentId = documentSnapshot.documentID;
         }));
       });
       print(itemQuery);
       var itemSnapshot = await Firestore.instance.collection(documentId).getDocuments();
      print(itemSnapshot);
      } catch (error) {
        print(error);
    }
  
};