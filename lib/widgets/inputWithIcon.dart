import 'package:befikr_app/screens/authScreen.dart';
import 'package:flutter/material.dart';

class InputWithIcon extends StatefulWidget {
  final IconData icon;
  final String hint;
  InputWithIcon({this.icon, this.hint});

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFBC7C7C7),
          width: 2
        ),
        borderRadius: BorderRadius.circular(50)
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60,
            child: Icon(
              widget.icon,
              size: 20,
              color: Color(0xFFBB9B9B9),
            )
          ),
          Expanded(
            child: TextField(
              controller: (widget.hint.contains('Email'))? loginEmail : loginPass,
              obscureText: (widget.hint.contains('Email'))? false : true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontFamily: 'quicksand_bold',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}