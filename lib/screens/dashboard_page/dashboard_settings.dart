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
    return ListView(
              padding: const EdgeInsets.all(8),
              children:[
                Visibility(
                  visible: isAdmin,
                  child: RaisedButton(
                    child: Text("Admin"),
                    onPressed: onAdminButtonClicked,
                  ),
                ),
                RaisedButton(
                  child: Text("Balance Management"),
                  onPressed: onLogoutClicked,
                ),
                RaisedButton(
                  child: Text("Logout"),
                  onPressed: onLogoutClicked,
                )
              ]
            );
  }
}
