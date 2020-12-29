import 'package:flutter/material.dart';


class Splashpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.of(context).size.width ,height: MediaQuery.of(context).size.height,
          child: Container(

        child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
                      child: Text("DeepFake",
                          style: TextStyle(
                            color: Color(0xffe06666),
                            fontFamily: 'Oswald',
                            fontSize: 45,
                          )),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
                      child: Text("Detection",
                          style: TextStyle(
                              color: Theme.of(context).errorColor,
                              fontFamily: 'Oswald',
                              fontSize: 45)),
                    ),
                  ],
                ),

        
      ),
    );
  }
}