import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/actions/user_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/user_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:food/actions/item_action.dart';
import 'package:food/actions/menu_action.dart';
import 'package:food/actions/category_action.dart';

class UserLoginRequest {}

class UserLoginSuccess {
  UserLoginSuccess();

  @override
  String toString() {
    return 'UserLoginSuccess';
  }
}

class UserLoginFailure {
  final dynamic error;

  UserLoginFailure(this.error);

  @override
  String toString() {
    return 'LogIn{There was an error loggin in: $error}';
  }
}

class UserLogout {
  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}

class UserLogoutFailure {
  final dynamic error;

  UserLogoutFailure(this.error);

  @override
  String toString() {
    return 'LogOut{There was an error loggin out: $error}';
  }
}

ThunkAction<AppState> createLogOutMiddleware = (Store<AppState> store) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _googleSignIn.signOut();
    await _auth.signOut();
    store.dispatch(UserLogout());
    store.dispatch(NavigateToAction.replace('/'));
    print('logging out...');
  } catch (error) {
    print(error);
  }
};

ThunkAction<AppState> createLogInMiddleware = (Store<AppState> store) async {
//  await store.dispatch(UserLoginRequest());
  FirebaseUser userFirebase;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  try {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    userFirebase = (await _auth.signInWithCredential(credential)).user;

    //Check user already exist
    CollectionReference ref = Firestore.instance.collection('user');
    DocumentSnapshot userSnapshot = await ref.document(userFirebase.uid).get();

    if (userSnapshot.exists) {
      await store.dispatch(new UserLoginSuccess());
      await store.dispatch(new SetUserState(new UserState(
          name: userFirebase.displayName,
          email: userFirebase.email,
          uid: userFirebase.uid,
          isAdmin: userSnapshot.data["isAdmin"],
          adminMenus: null)));
    } else {
      //If not, add to our database
      await ref.document(userFirebase.uid).setData({
        'email': userFirebase.email,
        'name': userFirebase.displayName,
        'isAdmin': false
      });
      await store.dispatch(new UserLoginSuccess());
      await store.dispatch(new SetUserState(new UserState(
          name: userFirebase.displayName,
          email: userFirebase.email,
          uid: userFirebase.uid,
          isAdmin: false,
          adminMenus: null)));
    }
    
    //Retrieve data for all items
    await store.dispatch(retrieveMenu); 
    await store.dispatch(retrieveCategories);
    await store.dispatch(retrieveItems);

    //Open Dashboard
    await store.dispatch(NavigateToAction.replace('/dashboard'));

  } catch (error) {
    store.dispatch(new UserLoginFailure(error));
  }
};
