import 'package:flutter/material.dart';

class firstPage extends StatefulWidget {
  @override
  _firstPageState createState() => _firstPageState();
}

class _firstPageState extends State<firstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
                  color: Color(0xff3f3d56),
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
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Colors.grey,size: 16,),
                              Text(
                                " Bengaluru",
                                style: TextStyle(
                                  fontFamily: 'quicksand_bold',
                                  fontSize: 16,
                                  color: Colors.grey,
                                  letterSpacing: 0.6,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 30,),
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.phone, color: Colors.grey,size: 16,),
                              Text(
                                " 9448241873",
                                style: TextStyle(
                                  fontFamily: 'quicksand_bold',
                                  fontSize: 16,
                                  color: Colors.grey,
                                  letterSpacing: 0.6,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.email_outlined, color: Colors.grey,size: 16,),
                              Text(
                                " mpratyush2008@gmail.com",
                                style: TextStyle(
                                    fontFamily: 'quicksand_bold',
                                    fontSize: 16,
                                    color: Colors.grey,
                                    letterSpacing: 0.6
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height/2 + 20,
                child: Container(
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/2 + 20,
                    width: MediaQuery.of(context).size.width,

                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Family Members",
                            style: TextStyle(
                                fontFamily: 'quicksand_bold',
                                fontSize: 25,
                                letterSpacing: 0.6,
                                color: Colors.black
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Dad",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'quicksand_bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(width: 30),
                                Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Mom",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'quicksand_bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                ),
                                SizedBox(width: 30),
                                Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'quicksand_bold',
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        )

                      ],
                    )
                ),
              )
            ],
          ),
        )
    );
  }
}


