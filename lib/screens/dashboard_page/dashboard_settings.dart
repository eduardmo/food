import 'package:flutter/material.dart';

class DashboardSettings extends StatelessWidget {
  bool isAdmin = false;

  DashboardSettings(bool isAdmin) {
    this.isAdmin = isAdmin;
    print(isAdmin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: isAdmin,
              child: RaisedButton(
                child: Text("Admin"),
                onPressed: () => {print("Pressed Admin!")},
              ),
            ),
            RaisedButton(
                child: Text("User Profile"),
                onPressed: () => {print(isAdmin), print("Pressed Not Admin!")})
          ],
        ));
  }
}
