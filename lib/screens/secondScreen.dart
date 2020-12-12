import 'dart:math';

import 'package:befikr_app/utils/constants.dart';
import 'package:befikr_app/widgets/circlePainter.dart';
import 'package:befikr_app/widgets/curve_wave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:location/location.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

int count = 0;

int flag = 0;


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

  bool _hasSpeech = false;
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();


  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
      onError: errorListener, 
      onStatus: statusListener, 
      debugLogging: true
    );
    if (hasSpeech) {
      _localeNames = await speech.locales();

      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
    // startListening();
    
  }

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(minutes: 1),
        pauseFor: Duration(seconds: 20),
        partialResults: true,
        onDevice: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void stopListening() {
    speech.stop();
    print('Stopped');
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;
    print('Result listener ${result.recognizedWords}');
    if(result.recognizedWords.contains('help')) {
      Fluttertoast.showToast(msg: "Help !!");
    }
    setState(() {
      lastWords = '${result.recognizedWords} - ${result.finalResult}';
    });
    startListening();
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.level = level;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    print("Received error status: $error, listening: ${speech.isListening}");
    startListening();
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    // 'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
      print('Last Status : $status');
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
    print(selectedVal);
  }

  Widget _button() {
    return HoldDetector(
      onHold: () async {
        count++;
        print(count);
        if(count == 5 && flag == 0) {
          // count = 0;
          flag =1 ;
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
          if(flag == 1) await initSpeechState();
          (!_hasSpeech || speech.isListening)? print('$_hasSpeech | ${speech.isListening} ') : startListening();
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
