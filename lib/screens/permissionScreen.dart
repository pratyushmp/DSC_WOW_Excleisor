import 'package:befikr_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Permission extends StatefulWidget {
  @override
  _PermissionState createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset('assets/permission.png'),
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
              SizedBox(height: 60,),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.withOpacity(0.5),
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
                      Icon(Icons.error, color: Colors.red[700],)
                    ],
                  ),
                ),
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
              Container(
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


            ],
          )
        ),
      ),
    );
  }
}

