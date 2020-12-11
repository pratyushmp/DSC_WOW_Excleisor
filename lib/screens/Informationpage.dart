import 'package:befikr_app/widgets/primaryButton.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

var datestring = "";

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => new _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String date = "";
  int currentStep = 0;
  bool complete = false;

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
                                    child: TextField(decoration: null),
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
                                        decoration: null, keyboardType: TextInputType.number),
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
                                    Padding(
                                      padding: const EdgeInsets.only(right: 25.0),
                                      child: Container(
                                        child: PrimaryButton(
                                          btnText: 'Next',
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
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Home Address'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Postcode'),
                          ),
                        ],
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
}
