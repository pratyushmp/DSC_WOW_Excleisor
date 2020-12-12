import 'package:befikr_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
            color: secondaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pratyush M",
                style: TextStyle(
                  fontFamily: 'quicksand_bold',
                  fontSize: 30,
                  color: Colors.white,
                  letterSpacing: 0.6
                )
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.grey,size: 12,),
                            Text(
                              " Bengaluru",
                              style: TextStyle(
                                fontFamily: 'quicksand_bold',
                                fontSize: 12,
                                color: Colors.grey,
                                letterSpacing: 0.6,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.white.withOpacity(0.2),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.email_outlined, color: Colors.grey,size: 12,),
                          Text(
                            " mpratyush2008@gmail.com",
                            style: TextStyle(
                              fontFamily: 'quicksand_bold',
                              fontSize: 12,
                              color: Colors.grey,
                              letterSpacing: 0.6
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
