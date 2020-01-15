import 'package:flutter/material.dart';
import 'package:flutter_flipperkit/flutter_flipperkit.dart';
import 'package:flutter_flipperkit/plugins/redux/flipper_reduxinspector_plugin.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/containers/googleButton.dart';
import 'package:food/models/app_state.dart';
import 'package:redux/redux.dart';

class GoogleAuthButtonContainer extends StatelessWidget {
  GoogleAuthButtonContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  	// Connect to the store:
   
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
      	// We haven't made this yet.
        return new GoogleAuthButton(
          buttonText: vm.buttonText,
          onPressedCallback: vm.onPressedCallback,
        );
      },
    );
  }
}

class _ViewModel {
  final String buttonText;
  final Function onPressedCallback;

  _ViewModel({this.onPressedCallback, this.buttonText});

  static _ViewModel fromStore(Store<AppState> store) {
  	// This is a bit of a more complex _viewModel
  	// constructor. As the state updates, it will
  	// recreate this _viewModel, and then pass
  	// buttonText and the callback down to the button
  	// with the appropriate qualities:
  	//
    return new _ViewModel(
        buttonText: 'Log in with Google',
        onPressedCallback: () {
        store.dispatch(createLogInMiddleware);    
        });
  }
}