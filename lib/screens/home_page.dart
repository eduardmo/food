import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/actions/menu_actions.dart';
import 'package:food/containers/buttons.dart';
import 'package:redux/redux.dart';
import '../models/app_state.dart';
import '../styles/colors.dart';
import '../styles/styles.dart';

class HomePage extends StatefulWidget {
  final String pageTitle;

  HomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/welcome.png', width: 190, height: 190),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 0),
                  child: Text('Fryo!', style: logoStyle),
                ),
                Container(
                  width: 200,
                  margin: EdgeInsets.only(bottom: 0),
                  child: froyoFlatBtn('Sign In', (){ 
                    vm.onPressedCallback();
                    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignInPage()));
                  }),
                ),
                Container(
                  width: 200,
                  padding: EdgeInsets.all(0),
                  child: froyoOutlineBtn('Sign Up', (){
                    // Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),  child: SignUpPage()));
                    // Navigator.of(context).pushReplacementNamed('/signup');
                   }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
      
                    children: <Widget>[
                      Text('Langauage:', style: TextStyle(color: darkText)),
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text('English ›', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                )
              ],
            )),
            backgroundColor: bgColor,
          );
            }
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
        store.dispatch(retrieveItem);    
        });
  }
}
