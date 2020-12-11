import 'package:befikr_app/utils/constants.dart';
import 'package:befikr_app/widgets/primaryButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

var datestring = "";

TextEditingController nameController = TextEditingController();
TextEditingController phoneNumber = TextEditingController();
String dob;

class InfoPage extends StatefulWidget {
  User user;
  InfoPage({this.user});
  @override
  _InfoPageState createState() => new _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String date = "";
  int currentStep = 0;
  bool complete = false;

  List<Widget> familyCards = [];

  int familyMembers = 1;
  int first = 0;

  next() {
    currentStep + 1 != 2
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(first==0) {
      familyCards.add(addFamilyCard(1));
      // familyCards.add(addFamilyCard(2));
      first = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(children: <Widget>[
            Expanded(
              child: Stepper(
                  steps: [
                    Step(
                        title: const Text('Personal Information'),
                        isActive: currentStep == 0 ? true : false,
                        state: StepState.editing,
                        content: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/information.png'),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "Name",
                                  style: TextStyle(
                                    fontFamily: 'quicksand_bold',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Container(
                                  height: 40,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.red,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: nameController,
                                      decoration: null
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "Date of Birth",
                                  style: TextStyle(
                                    fontFamily: 'quicksand_bold',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    DateTime response = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate: DateTime.now(),
                                        lastDate: DateTime.now());
                                    setState(() {
                                      datestring = printdate(response);
                                      dob = datestring;
                                    });

                                  },
                                  child: Container(
                                    height: 40,
                                    width: 260,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      // color: Colors.red,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.calendar_today_rounded)
                                        ),
                                        Expanded(
                                            child: Text(
                                                datestring,
                                            style: TextStyle(
                                              fontFamily: 'quicksand_bold',
                                              color: Colors.black,
                                            ),))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    fontFamily: 'quicksand_bold',
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Container(
                                  height: 40,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                    // color: Colors.red,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: phoneNumber,
                                      decoration: null, 
                                      keyboardType: TextInputType.number
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        Loader.show(context,progressIndicator: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                        ));
                                        await Firebase.initializeApp();

                                        var databaseReference = FirebaseDatabase.instance.reference();
                                        await databaseReference.child('Users').child('${widget.user.uid}').set({
                                          'Email':widget.user.email,
                                          'Name':nameController.text,
                                          'Phone Number':phoneNumber.text,
                                        });

                                        Loader.hide();
                                        currentStep++;
                                        setState(() {
                                          
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 25.0),
                                        child: Container(
                                          child: PrimaryButton(
                                            btnText: 'Next',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    Step(
                      isActive: currentStep == 1 ? true : false,
                      state: StepState.editing,
                      title: const Text('Add Family'),
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/2.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/family.png'),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            Text(
                              "Add Family Members ",
                              style: TextStyle(
                                fontFamily: 'quicksand_bold',
                                fontSize: 20
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: familyCards.length,
                                separatorBuilder: (context,int index) {
                                  return SizedBox(height:20);
                                },
                                itemBuilder: (context,int index) {
                                  return familyCards[index];
                                },
                              ),
                            ),

                            SizedBox(height:20),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:15.0,horizontal: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          if(familyMembers == 5) {
                                            Fluttertoast.showToast(
                                              msg: "Can't Add More Members",
                                            );
                                          }else {
                                            familyMembers++;
                                            familyCards.add(addFamilyCard(familyMembers));
                                            setState(() {
                                              
                                            }); 
                                          }
                                        },
                                        child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                                        child: Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(10)
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Text(
                                              "Add + ",
                                              style: TextStyle(
                                                fontFamily: 'quicksand_bold',
                                                color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:10.0),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              fontFamily: 'quicksand_bold',
                                              color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height:20),
                          ],
                        ),
                      ),
                    ),
                  ],
                  currentStep: currentStep,
                  type: StepperType.horizontal,
                  onStepContinue: next,
                  onStepTapped: (step) => goTo(step),
                  onStepCancel: cancel,
                  controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) =>
                      Container()),
            ),
          ]),
        ));
  }
  String printdate(response) {
    var date = response.day;
    var month = response.month;
    var year = response.year;
    return "$date/$month/$year";
  }

  Widget addFamilyCard(int index) {
    return Container(
      // height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0,7),
            blurRadius: 20
          )
        ]
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
            child: Row(
              children: [
                Text(
                  "Family Member $index",
                  style: TextStyle(
                    fontFamily: 'quicksand_bold'
                  ),
                ),

                Spacer(),

                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    if(familyMembers == 1) {
                      Fluttertoast.showToast(msg: "Minimum Members should be 1");
                    } else {
                      familyCards.removeAt(index-1);
                      familyMembers--;
                      setState(() {
                        
                      });
                    }
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Name",
                hintStyle: TextStyle(
                  fontFamily: 'quicksand_bold',
                )
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Relation",
                hintStyle: TextStyle(
                  fontFamily: 'quicksand_bold',
                )
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Phone Number",
                hintStyle: TextStyle(
                  fontFamily: 'quicksand_bold',
                )
              ),
            ),
          ),

          SizedBox(height:10),
        ],
      ),
    );
  }
}
