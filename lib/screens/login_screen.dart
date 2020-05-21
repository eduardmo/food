import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/auth_action.dart';
import 'package:food/models/app_state.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatefulWidget {
   final Widget child;
  final bool expand;
  LoginScreen({this.expand = false, this.child});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation; 
  bool isOffice = false;

  @override
  void initState() {
    super.initState();
  }


_getBackBtn() {
  return Positioned(
    top: 35,
    left: 25,
    child: Icon(
      Icons.arrow_back_ios,
      color: Colors.white,
    ),
  );
}

_getBottomRow(context) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
                  child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    ),
  );
}

_getSignIn(Function onPressedCallback) {
  return Expanded(
    flex: 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Sign in',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        GestureDetector(
          onTap: () {
            onPressedCallback();
          },
          child: CircleAvatar(
          backgroundColor: Colors.grey.shade800,
          radius: 40,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
        )
      ],
    ),
  );
}

_getTextFields() {
  return Expanded(
    flex: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: LiteRollingSwitch(
                value: true,
                textOn: 'Office',
                textOff: 'Guest',
                colorOn: Color.fromRGBO(123, 194, 52, 100),
                colorOff: Color.fromRGBO(16, 20, 126, 100),
                iconOn: Icons.work,
                iconOff: Icons.person,
                onTap: () {
                  setState(() {
                isOffice = !isOffice;
                });
                },
                onChanged: (bool state) {
                },
              ),
        ),
        getGuestFields(),
      ],
    ),
  );
}

getGuestFields() {
     return AnimatedOpacity(
      opacity: isOffice ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Column(
          children: <Widget>[
             SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        SizedBox(
          height: 15,
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Password'),
        ),
        SizedBox(
          height: 25,
        ),
          ],
        )
    );
}

_getHeader() {
 return Expanded(
    flex: 3,
    child: Container(
      alignment: Alignment.bottomLeft,
      child: Text(
        'Enjoy the\nFryday',
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    ),
  );
}

@override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
    return Scaffold(
      body: CustomPaint(
        painter: BackgroundSignIn(),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  _getHeader(),
                  _getTextFields(),
                  _getSignIn(vm.onPressedCallback),
                  _getBottomRow(context),
                ],
              ),
            ),
            _getBackBtn(),
          ],
        ),
      ),
    );
      }
    );
  }
}

   class _ViewModel {
  final Function onPressedCallback;

  _ViewModel({this.onPressedCallback});

  static _ViewModel fromStore(Store<AppState> store) {
  	// This is a bit of a more complex _viewModel
  	// constructor. As the state updates, it will
  	// recreate this _viewModel, and then pass
  	// buttonText and the callback down to the button
  	// with the appropriate qualities:
  	//
    return new _ViewModel(

        onPressedCallback: () {
          store.dispatch(createLogInMiddleware);
        });
  }
}

class BackgroundSignIn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.grey.shade100;
    canvas.drawPath(mainBackground, paint);

    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.5);
    blueWave.quadraticBezierTo(sw * 0.5, sh * 0.45, sw * 0.2, 0);
    blueWave.close();
    paint.color = Color.fromRGBO(123, 194, 52, 100);
    canvas.drawPath(blueWave, paint);

    Path greyWave = Path();
    greyWave.lineTo(sw, 0);
    greyWave.lineTo(sw, sh * 0.1);
    greyWave.cubicTo(
        sw * 0.95, sh * 0.15, sw * 0.65, sh * 0.15, sw * 0.6, sh * 0.38);
    greyWave.cubicTo(sw * 0.52, sh * 0.52, sw * 0.05, sh * 0.45, 0, sh * 0.4);
    greyWave.close();
    paint.color = Color.fromRGBO(16, 20, 126, 100);
    canvas.drawPath(greyWave, paint);

    Path yellowWave = Path();
    yellowWave.lineTo(sw * 0.7, 0);
    yellowWave.cubicTo(
        sw * 0.6, sh * 0.05, sw * 0.27, sh * 0.01, sw * 0.18, sh * 0.12);
    yellowWave.quadraticBezierTo(sw * 0.12, sh * 0.2, 0, sh * 0.2);
    yellowWave.close();
    paint.color = Colors.grey.shade400;
    canvas.drawPath(yellowWave, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

 