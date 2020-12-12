import 'package:befikr_app/screens/authScreen.dart';
import 'package:befikr_app/screens/homeScreen.dart';
import 'package:befikr_app/screens/onboardingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

Future manageRoutes(context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  if(preferences.getBool('firstTime') == null)
    return OnboardingScreen();
  else {
    await Firebase.initializeApp();
    var user =  FirebaseAuth.instance.currentUser;
    if ( user != null) {
      return Home();
    } else {
      return AuthScreen();
    }
  }
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: manageRoutes(context),
      builder: (context,snapshot) {
        if(snapshot.hasData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              body: snapshot.data,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      } 
    );
  }
}

