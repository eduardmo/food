import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:food/actions/Admin/admin_menus_action.dart';
import 'package:food/models/app_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:food/styles/colors.dart';
import 'package:redux/redux.dart';

class CreateMenu extends StatelessWidget {
  final String pageTitle;

  CreateMenu({Key key, this.pageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return new Scaffold(
              appBar: AppBar(
                  title: const Text('Create Menu'),
                  backgroundColor: primaryColor),
              body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MenuForm(onFormSubmit: vm.onFormSubmit)));
        });
  }
}

class _ViewModel {
  final Function onFormSubmit;

  _ViewModel({this.onFormSubmit});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(onFormSubmit: (MenuState menuState) {
      store.dispatch(saveNewMenu(menuState));
    });
  }
}

class _MenuFormData {
  String restaurantName = "";
  String email = "";
  String phone;
  String address = "";
}

// Create a Form widget.
class MenuForm extends StatefulWidget {
  final Function onFormSubmit;

  MenuForm({this.onFormSubmit});

  @override
  MenuFormState createState() {
    return MenuFormState(onFormSubmit: this.onFormSubmit);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MenuFormState extends State<MenuForm> {
  final Function onFormSubmit;
  _MenuFormData _menuFormData = new _MenuFormData();

  MenuFormState({this.onFormSubmit});

  final _createMenuKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _createMenuKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                return value.length < 3
                    ? "Please enter restaurant name (Min 3 character)"
                    : null;
              },
              keyboardType: TextInputType.text,
              onSaved: (value) {
                _menuFormData.restaurantName = value;
              },
              decoration: InputDecoration(hintText: "Restaurant Name"),
            ),
            TextFormField(
              validator: (value) {
                return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value) ||
                        value.length < 3
                    ? "Please enter email address"
                    : null;
              },
              onSaved: (value) {
                _menuFormData.email = value;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              keyboardType: TextInputType.phone,
              validator: (value) {
                return value.length < 3 ? "Please enter phone number" : null;
              },
              decoration: InputDecoration(hintText: "Phone"),
              onSaved: (value) {
                _menuFormData.phone = value;
              },
            ),
            TextFormField(
              validator: (value) {
                return value.length < 3
                    ? "Please enter restaurant address"
                    : null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: InputDecoration(hintText: "Address"),
              onSaved: (value) {
                _menuFormData.address = value;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("Submit"),
                onPressed: () {
                  if (_createMenuKey.currentState.validate()) {
                    _createMenuKey.currentState.save();
                    this.onFormSubmit(new MenuState(
                        name: _menuFormData.restaurantName,
                        address: _menuFormData.address,
                        phone: _menuFormData.phone,
                        email: _menuFormData.email,
                        isActive: false));
                  }
                },
              ),
            )
          ],
        ));
  }
}
