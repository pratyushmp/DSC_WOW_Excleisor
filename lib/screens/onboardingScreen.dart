import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';

import 'authScreen.dart';

class OnboardingScreen extends StatelessWidget {

  final List<Introduction> list = [
    Introduction(
      title: 'Share Location',
      subTitle: 'Share your location with simple touch of a button',
      imageUrl: 'assets/location.png',

    ),
    Introduction(
      title: 'Voice Commands',
      subTitle: 'With Voice Commands the app starts listening to your voice for distress signals',
      imageUrl: 'assets/voice.png',
    ),
    Introduction(
      title: 'Alert Nearby Police Station',
      subTitle: 'Your location is sent to nearby police station for immediate help and assistance',
      imageUrl: 'assets/alert.png',
    ),
    Introduction(
      title: 'GeoFencing',
      subTitle: 'With GeoFencing the app will automatically sense if you are out of your home and be on Alert mode',
      imageUrl: 'assets/home.png',
    ),
    Introduction(
      title: "Let's Start",
      subTitle: ' ',
      imageUrl: 'assets/start.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(introductionList: list, onTapSkipButton: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ), //MaterialPageRoute
      );
    },);
  }
}
