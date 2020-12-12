import 'package:befikr_app/screens/infoScreen.dart';
import 'package:befikr_app/screens/verifyScreen.dart';
import 'package:befikr_app/utils/authentication.dart';
import 'package:befikr_app/utils/constants.dart';
import 'package:befikr_app/widgets/inputWithIcon.dart';
import 'package:befikr_app/widgets/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



TextEditingController loginEmail = TextEditingController();
TextEditingController loginPass = TextEditingController();

TextEditingController createEmail = TextEditingController();
TextEditingController createPass = TextEditingController();
TextEditingController createConfPass = TextEditingController();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginUser('aswingopinathan1871@gmail.com', 'asdfghjkl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 5, right: 5),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/login.png'),
                          fit: BoxFit.cover)),
                  height: MediaQuery.of(context).size.height / 3,
                  // child: Image.asset(,fit: BoxFit.contain,),
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 25, right: 25),
                          child: InputWithIcon(
                            hint: 'Enter Email',
                            icon: Icons.email_outlined,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 25, right: 25),
                          child: InputWithIcon(
                            hint: 'Enter Password',
                            icon: Icons.vpn_key_outlined,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response = await loginUser(
                                loginEmail.text, loginPass.text);
                            print(response);
                            if(response.runtimeType.toString() == 'User') {
                              if (!response.emailVerified) {
                                await response.sendEmailVerification();
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => VerifyScreen(email:response.email),
                                ));
                              } else {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => InfoPage(user: response,),
                                ));
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: PrimaryButton(
                              btnText: 'Login',
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: <Widget>[
                              Row(children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey[300],
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'quicksand_bold'),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.grey[300],
                                  thickness: 1,
                                )),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.red),
                                  child: InkWell(
                                      onTap: () async {
                                        var response = await signInWithGoogle();
                                        if(response.runtimeType.toString() == 'UserCredential') {
                                          if (!response.user.emailVerified) {
                                            await response.user.sendEmailVerification();
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => VerifyScreen(email:response.user.email),
                                            ));
                                          } else {
                                            
                                          }
                                        }
                                      },
                                      customBorder: CircleBorder(),
                                      child: Center(
                                          child: FaIcon(FontAwesomeIcons.google,
                                              color: Colors.white)))),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.indigo),
                                child: InkWell(
                                  onTap: () async {
                                    Loader.show(context, progressIndicator: CircularProgressIndicator());
                                    var response = await signInWithFacebook();
                                    Loader.hide();
                                    if(response != null) print(response.user.uid);
                                    // print(response.user.uid);
                                  },
                                  customBorder: CircleBorder(),
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Account ?",
                              style: TextStyle(fontFamily: 'quicksand_bold'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                scaffoldState.currentState.showBottomSheet(
                                  (context) {
                                    return Container(
                                      
                                      decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),

                                        )
                                      ),
                                      height: MediaQuery.of(context).size.height/2,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20,),

                                            Text(
                                              "Create an Account",
                                              style: TextStyle(
                                                fontFamily: 'quicksand_bold',
                                                fontSize: 25,
                                                color: Colors.white
                                              ),
                                            ),

                                            SizedBox(height: 20,),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                                              child: TextField(
                                                controller: createEmail,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  prefixIcon: Icon(Icons.email_outlined),
                                                  hintText: 'Email',
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'quicksand_bold'
                                                  ),
                                                  focusColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    
                                                  )
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 10,),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                                              child: TextField(
                                                controller: createPass,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  prefixIcon: Icon(Icons.vpn_key_outlined),
                                                  hintText: 'Password',
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'quicksand_bold'
                                                  ),
                                                  focusColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    
                                                  )
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 10,),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal:20.0),
                                              child: TextField(
                                                controller: createConfPass,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  prefixIcon: Icon(Icons.vpn_key_outlined),
                                                  hintText: 'Confirm Password',
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'quicksand_bold'
                                                  ),
                                                  focusColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    
                                                  )
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 20,),

                                            GestureDetector(
                                              onTap: () async {
                                                if(createPass.text != createConfPass.text) {
                                                  Fluttertoast.showToast(
                                                    msg: "Confirm Password Should be same as Password",
                                                  );
                                                }
                                                else {
                                                  Loader.show(context,progressIndicator: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                                  ));
                                                  var response = await registerUser(createEmail.text,createPass.text);
                                                  // await Future.delayed(Duration(seconds: 1));
                                                  Loader.hide();
                                                  if(response == 'The password provided is too weak.') {
                                                    Fluttertoast.showToast(
                                                      msg: "Password Length Should be more than 6 characters",
                                                    );
                                                  } else if(response == 'The account already exists for that email.') {
                                                    Fluttertoast.showToast(
                                                      msg: "Account Already Exists , Please Login with your credentials",
                                                    );
                                                  } else if(response.runtimeType.toString() == 'UserCredential'){
                                                    Navigator.pop(context);
                                                    showAlertDialog(context, createEmail.text);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                      msg: "Registration Failed , Please Try Again Later",
                                                    );
                                                  }
                                                }
                                              },
                                              child: Center(
                                                child: Container(
                                                  height: 50,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Create",
                                                      style: TextStyle(
                                                        fontFamily: 'quicksand_bold',
                                                        fontSize: 20
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // SizedBox(height: 40,),

                                            // Center(
                                            //   child: Container(
                                            //     height: 50,
                                            //     width: 120,
                                            //     decoration: BoxDecoration(
                                            //       color: Colors.white,
                                            //       borderRadius: BorderRadius.circular(5)
                                            //     ),
                                            //     child: Center(
                                            //       child: Text(
                                            //         "Cancel",
                                            //         style: TextStyle(
                                            //           fontFamily: 'quicksand_bold',
                                            //           fontSize: 20
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Create an Account.",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dotted,
                                  fontFamily: 'quicksand_bold',
                                  color: primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context,String email) {

    

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registration Successful !!"),
          content: Text("Verification Email has been sent to your email : $email . Please Verfiy your account and Login here."),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () { 
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
