import 'package:flutter/material.dart';
import 'home.dart';

class Aboutus extends StatelessWidget {
  final controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: PageView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Color(0xffA06CD9),
                  ),
                  Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Sanskar Garodia'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
