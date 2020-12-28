import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.white, 
        ),
        child: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'DeepFake',
                  style: TextStyle(color: Theme.of(context).backgroundColor),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ListTile(
                title: Text("About"),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.pushNamed(context, '/aboutus');
                },
              ),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),appBar: AppBar(
      actions: <Widget>[],
    ),
    );
  }
}