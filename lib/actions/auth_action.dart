import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserLoginRequest {}

class UserLoginSuccess {
  final User user;
  UserLoginSuccess(this.user);

  @override
  String toString() {
    return 'LogIn{user: $user}';
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
 await store.dispatch(UserLoginRequest());
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
        CollectionReference ref = Firestore.instance.collection('user');        
        await ref.document(userFirebase.uid).setData({
          'email': userFirebase.email,
          'name': userFirebase.displayName
        });
        store.dispatch(new UserLoginSuccess(User(userFirebase.displayName, userFirebase.email, userFirebase.uid)));
        await store.dispatch(NavigateToAction.replace('/main'));

      } catch (error) {
        store.dispatch(new UserLoginFailure(error));
      }
    
};