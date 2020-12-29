import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'FaceSham',
                style: TextStyle(color: Theme.of(context).backgroundColor,fontSize: 20,fontFamily: 'Oswald'),
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
    );
  }
}
