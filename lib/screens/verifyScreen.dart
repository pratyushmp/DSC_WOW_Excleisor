import 'package:befikr_app/widgets/primaryButton.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  String email;
  VerifyScreen({this.email});
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/auth.png')
              )
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Text(
                    "A Verification Link has been sent to your \nEmail Address : ${widget.email}"
                    " , \nPlease Verify your account before accessing Befikr ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'quicksand_bold'
                    ),
                  ),
                ),

                SizedBox(height:10),

                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0),
                    child: PrimaryButton(
                      btnText: 'Go Back to Login',
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}