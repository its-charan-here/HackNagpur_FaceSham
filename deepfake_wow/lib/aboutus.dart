import 'widgets/appbar.dart';
import 'package:flutter/material.dart';
// import 'home.dart';
import 'widgets/appbar.dart';

class Aboutus extends StatelessWidget {
  final controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: CustomAppBar(),
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
                    backgroundImage: AssetImage('assets/think.png'),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: ListTile(
                            title: Text(
                              'Deepfake detection includes solutions that leverage multi-modal detection techniques to determine whether target media has been manipulated or synthetically generated. \n\nExisting detection techniques can be loosely split into manual and algorithmic methods. Manual techniques include human media forensic practitioners, often armed with software tools. Algorithmic detection uses an AI-based algorithm to identify manipulated media.',
                              style:
                                  TextStyle(fontFamily: 'Oswald', fontSize: 20),
                            ),
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Text(
                                  'Created By:-',
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Oswald'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Vignesh Charan',
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Oswald'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Poojan Panchal',
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Oswald'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Sanskar Garodia',
                                  style: TextStyle(
                                      fontSize: 20, fontFamily: 'Oswald'),
                                ),
                              )
                            ],
                          ),
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
