import 'package:flutter/material.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:firebase_database/firebase_database.dart';
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
    CollectionReference ref = Firestore.instance.collection('user');        
QuerySnapshot eventsQuery = await ref
    .getDocuments()
    .then((QuerySnapshot snapshot) {
    snapshot.documents.forEach((f) => print('${f.data}}'));
  });


      try {
        await _googleSignIn.signOut();
        await _auth.signOut();
        store.dispatch(UserLogout());
        print('logging out...');

      } catch (error) {
        print(error);
    }
  
};

ThunkAction<AppState> createLogInMiddleware = (Store<AppState> store) async {
  store.dispatch(UserLoginRequest());
    // FirebaseUser is the type of your User.
    FirebaseUser userFirebase;
    // Firebase 'instances' are temporary instances which give
    // you access to your FirebaseUser. This includes
    // some tokens we need to sign in.
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // GoogleSignIn is a specific sign in class.
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    // Actions are classes, so you can Typecheck them
  
      try {
        // Try to sign in the user.
        // This method will either log in a user that your Firebase
        // is aware of, or it will prompt the user to log in
        // if its the first time.
        //
        GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // After checking for authentication,
        // We wil actually sign in the user
        // using the token that firebase.
        userFirebase = (await _auth.signInWithCredential(credential)).user;
        store.dispatch(new UserLoginSuccess(User(
            userFirebase.displayName, userFirebase.email, userFirebase.uid)));
        // This can be tough to reason about -- or at least it was for me.
        // We're going to dispatch a new action if we logged in,
        //
        // We also continue the current cycle below by calling next(action).
        // store.dispatch(new UserLoginSuccess(user: userFirebase));
      } catch (error) {
        store.dispatch(new UserLoginFailure(error));
      }
    
};




