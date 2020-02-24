import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/screens/admin/MenuManagement_screen.dart';
import 'package:food/styles/colors.dart';


class AdminDashboard extends StatefulWidget {
  final String pageTitle;

  AdminDashboard({Key key, this.pageTitle}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}


class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      MenuManagement(),
      Text("Orders"),
      Text("UserBalance")
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Fryo Admin'),
          backgroundColor: primaryColor,

        ),
        body: Center(
          child: _tabs[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.apps),
              title: new Text('Menu'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.toys),
              title: new Text('Orders'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up),
                title: Text('User Balance')
            )
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,

        )
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


