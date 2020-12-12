import 'package:befikr_app/utils/constants.dart';
import 'package:befikr_app/widgets/circlePainter.dart';
import 'package:befikr_app/widgets/curve_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:holding_gesture/holding_gesture.dart';



class SecondScreen extends StatefulWidget {
  const SecondScreen({Key key, this.size = 80.0, this.color = Colors.red,
    this.onPressed,this.child,}) : super(key: key);
  final double size;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with TickerProviderStateMixin {
  AnimationController _controller;
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
        print('a');
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
                  primaryColor,
                  Color.lerp(primaryColor, Colors.black, .05)
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
