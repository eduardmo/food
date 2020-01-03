import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/models/app_state.dart';

import '../containers/buttonContainer.dart';

class MainScreen extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many main:',
            ),
            StoreConnector<AppState, String>(
              converter: (store) => store.state.auth.toString(),
              builder: (context, count) => Text(
                    '$count',
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        // Return a function to dispatch an increment action
        converter: (store) => () => store.dispatch(UserLoginRequest()),
        builder: (_, increment) =>  GoogleAuthButtonContainer(),
      ),
    );
  }
}