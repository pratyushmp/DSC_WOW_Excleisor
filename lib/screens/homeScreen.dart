import 'package:befikr_app/screens/infoScreen.dart';
import 'package:befikr_app/screens/authScreen.dart';
import 'package:befikr_app/screens/onboardingScreen.dart';
import 'package:befikr_app/screens/permissionScreen.dart';
import 'package:flutter/material.dart';
import 'package:ink_page_indicator/ink_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

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
    controller = PageIndicatorController()
      ..addListener(() {
        page.value = controller.page;
      });
  }

  List<Widget> _createChildren(int count) {
    final List<Widget> result = [
      AuthScreen(),
      InfoPage(),
      Permission()


    ];
    return result;
  }

  Widget buildInkPageIndicator(InkStyle style) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: InkPageIndicator(
              gap: 20,
              padding: 16,
              shape: shape,
              page: page,
              pageCount: 3,
              activeShape: activeShape,
              inactiveColor: Colors.grey.shade500,
              activeColor: Colors.grey.shade700,
              inkColor: Colors.grey.shade400,
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = _createChildren(3);

    shape = IndicatorShape.circle(5);
    activeShape = IndicatorShape.circle(5);

    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            buildInkPageIndicator(InkStyle.normal),
          ],
        ),
        InkWell(
          onTap: () => controller.animateToPage(
            controller.page != children.length - 1 ? children.length - 1 : 0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.ease,
          ),
          child: PageView(
            controller: controller,
            children: children,
          ),
        ),

      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
