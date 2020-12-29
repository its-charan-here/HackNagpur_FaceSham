// import 'dart:html';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:deepfake_wow/splashpage.dart';
import 'package:page_transition/page_transition.dart';

import 'home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'aboutus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primarySwatch: Colors.deepPurple,
          //primaryColor: Color(0xFF8185E2),
          primaryColor: Color(0xFFe06666),
          accentColor: Colors.amber,
          errorColor: Colors.black,
          // primaryColor: Colors.black,
          // primaryTextTheme: Colors.black87,
          canvasColor: Colors.grey[100],
          backgroundColor: Colors.grey[100]),
      home:AnimatedSplashScreen(splashTransition: SplashTransition.fadeTransition, splash:Splashpage(),pageTransitionType: PageTransitionType.leftToRight,splashIconSize:200,nextScreen: Home(),duration:100,),
      routes: {
        '/aboutus': (context) => Aboutus(),
        '/home': (context) => Home(),
      },
    );
  }
}
