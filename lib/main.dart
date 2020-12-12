import 'package:befikr_app/screens/homeScreen.dart';
import 'package:befikr_app/screens/onboardingScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

