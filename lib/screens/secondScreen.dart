import 'package:befikr_app/utils/constants.dart';
import 'package:befikr_app/widgets/circlePainter.dart';
import 'package:befikr_app/widgets/curve_wave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:location/location.dart';

int count = 0;



class SecondScreen extends StatefulWidget {
  SecondScreen({Key key, this.size = 80.0, this.color = Colors.red,
    this.onPressed,this.child,this.user}) : super(key: key);
  final double size;
  Color color;
  User user;
  final Widget child;
  final VoidCallback onPressed;
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with TickerProviderStateMixin {
  AnimationController _controller;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Widget _button() {

    
    return HoldDetector(
      onHold: () {
        count++;
        print(count);
        if(count == 5) {
          // count = 0;
          widget.color = Colors.green;
          Location.instance.onLocationChanged.listen((locationData) async {
            if (locationData != null) {
              await Firebase.initializeApp();
              var databaseReference = FirebaseDatabase.instance.reference();
              await databaseReference.child('Users').child(widget.user.uid).child('Location').set({
                'Lat':locationData.latitude,
                'Long':locationData.longitude
              });
            }
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            duration: Duration(seconds: 1),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You are SAFE !!",
                  style: TextStyle(
                    fontFamily: 'quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ));
          setState(() {
            
          });
        }
      }, 
      holdTimeout: Duration(milliseconds: 200),
      enableHapticFeedback: true,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.size),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[
                  widget.color,
                  Color.lerp(widget.color, Colors.black, .05)
                ],
              ),
            ),
            child: ScaleTransition(
                scale: Tween(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: const CurveWave(),
                  ),
                ),
                child: Icon(Icons.speaker_phone, size: 44,)
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: CustomPaint(
          painter: CirclePainter(
            _controller,
            color: widget.color,
          ),
          child: SizedBox(
            width: widget.size * 4.125,
            height: widget.size * 4.125,
            child: _button(),
          ),
        ),
      ),
    );
  }
}
