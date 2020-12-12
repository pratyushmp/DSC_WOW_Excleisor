import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

bool isChecked1 = true;
bool isChecked2 = true;
var buttonbg1 = Colors.green.withOpacity(0.5);
var buttonbg2 = Colors.green.withOpacity(0.5);

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset('assets/settings.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 45.0, left: 20),
          child: Text(
            "Settings",
            style: TextStyle(
              fontFamily: 'quicksand_bold',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 40,),
        FutureBuilder(
            future: checkLocationPermission(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool enabled = snapshot.data;
                print(enabled);
                return Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: enabled == true
                          ? Colors.green.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5),
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
                                letterSpacing: 0.6),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isChecked1 = !isChecked1;
                                if(isChecked1 == true) {
                                  buttonbg1 = Colors.green.withOpacity(0.5);
                                }
                                else {
                                  buttonbg1 = Colors.red.withOpacity(0.5);
                                }
                              });
                            },
                            child: CustomSwitchButton(
                              backgroundColor: buttonbg1,
                              unCheckedColor: Colors.red[700],
                              animationDuration: Duration(milliseconds: 400),
                              checkedColor: Colors.green[700],
                              checked: isChecked1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Container(
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
                        letterSpacing: 0.6),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked2 = !isChecked2;
                        if(isChecked2 == true) {
                          buttonbg2 = Colors.green.withOpacity(0.5);
                        }
                        else {
                          buttonbg2 = Colors.red.withOpacity(0.5);
                        }
                      });
                    },
                    child: CustomSwitchButton(
                      backgroundColor: buttonbg2,
                      unCheckedColor: Colors.red[700],
                      animationDuration: Duration(milliseconds: 400),
                      checkedColor: Colors.green[700],
                      checked: isChecked2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    ));
  }
}
