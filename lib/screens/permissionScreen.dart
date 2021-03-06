import 'package:befikr_app/screens/homeScreen.dart';
import 'package:befikr_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class Permission extends StatefulWidget {
  User user;
  Permission({this.user});
  @override
  _PermissionState createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {

  Future checkLocationPermission() async{
    var location = Location();
    bool enabled = await location.serviceEnabled();
    if(enabled == false) {
      await location.requestPermission();
    }
    return enabled;
  }

  Future checkMicrophonePermission() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/3,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/permission.png'),
                        fit: BoxFit.cover
                      )
                    ),
                    // child: Image.asset('assets/permission.png')
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "You are almost done!",
                  style: TextStyle(
                    fontFamily: 'quicksand_bold',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Before we move further we need a few permissions. These will enable the app to utilize all the tools required to keep you safe!",
                  style: TextStyle(
                    letterSpacing: 0.6,
                    fontFamily: 'quicksand_medium',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  "You can later turn them off from the settings menu.",
                  style: TextStyle(
                    letterSpacing: 0.6,
                    fontFamily: 'quicksand_medium',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30,),
                FutureBuilder(
                  future: checkLocationPermission(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      bool enabled = snapshot.data;
                      print(enabled);
                      return Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: enabled == true ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontFamily: 'quicksand_bold',
                                  fontSize: 16,
                                  letterSpacing: 0.6
                                ),
                              ),
                              Icon(enabled == true ? Icons.check_circle : Icons.error, color: enabled == true ? Colors.green[700] : Colors.red[700],)
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
                SizedBox(height: 20,),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Microphone",
                          style: TextStyle(
                              fontFamily: 'quicksand_bold',
                              fontSize: 16,
                              letterSpacing: 0.6
                          ),
                        ),
                        Icon(Icons.check_circle, color: Colors.green[700],)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Home(user: widget.user),
                    ));
                  },
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: primaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Let's Go",
                            style: TextStyle(
                              fontFamily: 'quicksand_bold',
                              fontSize: 16,
                              letterSpacing: 0.6,
                              color: Colors.white,
                            ),
                          ),
                          Icon(Icons.arrow_right_alt_rounded, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ),


              ],
            ),
          )
        ),
      ),
    );
  }
}

