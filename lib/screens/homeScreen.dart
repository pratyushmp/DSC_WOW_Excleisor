import 'package:befikr_app/screens/firstPage.dart';
import 'package:befikr_app/screens/infoScreen.dart';
import 'package:befikr_app/screens/authScreen.dart';
import 'package:befikr_app/screens/onboardingScreen.dart';
import 'package:befikr_app/screens/permissionScreen.dart';
import 'package:befikr_app/screens/secondScreen.dart';
import 'package:befikr_app/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ink_page_indicator/ink_page_indicator.dart';

class Home extends StatefulWidget {

  User user;

  Home({Key key,this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ValueNotifier<double> page = ValueNotifier(0.0);
  PageIndicatorController controller;

  IndicatorShape shape;
  IndicatorShape activeShape;

  @override
  void initState() {
    super.initState();
    controller = PageIndicatorController(initialPage: 1)
      ..addListener(() {
        page.value = controller.page;
      });
  }

  List<Widget> _createChildren(int count) {
    final List<Widget> result = [
      FirstPage(),
      SecondScreen(color: primaryColor,user: widget.user,),
      Permission()


    ];
    return result;
  }

  Widget buildInkPageIndicator(InkStyle style) {
    return InkPageIndicator(
      gap: 20,
      padding: 16,
      shape: shape,
      page: page,
      pageCount: 3,
      activeShape: activeShape,
      controller: controller,
      inactiveColor: Colors.grey.shade500,
      activeColor: Colors.grey.shade700,
      inkColor: Colors.grey.shade400,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = _createChildren(3);

    shape = IndicatorShape.circle(5);
    activeShape = IndicatorShape.circle(5);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            InkWell(
              child: PageView(
                controller: controller,
                children: children,
              ),
            ),
            Column(
              children: <Widget>[
                buildInkPageIndicator(InkStyle.simple),
              ],
            ),
            

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
