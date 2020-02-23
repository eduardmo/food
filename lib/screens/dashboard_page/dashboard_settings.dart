import 'package:flutter/material.dart';

class DashboardSettings extends StatelessWidget {
  bool isAdmin = false;
  Function onAdminButtonClicked;
  Function onUserProfileClicked;
  Function onLogoutClicked;

  DashboardSettings(bool isAdmin, Function onAdminButtonClicked,
      Function onUserProfileClicked, Function onLogoutClicked) {
    this.isAdmin = isAdmin;
    this.onAdminButtonClicked = onAdminButtonClicked;
    this.onUserProfileClicked = onUserProfileClicked;
    this.onLogoutClicked = onLogoutClicked;
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
                onPressed: onAdminButtonClicked,
              ),
            ),
            RaisedButton(
                child: Text("User Profile"), onPressed: onUserProfileClicked),
            RaisedButton(
              child: Text("Logout"),
              onPressed: onLogoutClicked,
            )
          ],
        ));
  }
}
