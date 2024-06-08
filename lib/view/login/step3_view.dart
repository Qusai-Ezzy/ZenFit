import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/select_datetime.dart';
import '../../common_widget/select_picker.dart';
import '../login/login.dart';

class Step3View extends StatefulWidget {
  const Step3View({Key? key});

  @override
  State<Step3View> createState() => _Step3ViewState();
}

class _Step3ViewState extends State<Step3View> {
  bool isMale = true;
  DateTime? selectDate;
  String? selectHeight;
  String? selectWeight;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.darkGrey, // Dark background
      appBar: AppBar(
        backgroundColor: TColor.orange, // Orange app bar background
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/img/back.png",
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          "Step 2 of 2",
          style: TextStyle(
            color: TColor.white, // White text color
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Personal Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.white, // White text color
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Let us know about you to speed up the results. Get fit with your personalized workout plan!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.white, // White text color
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: media.width * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Divider(color: TColor.divider, height: 1),
                  SelectDateTime(
                    title: "Birthday",
                    didChange: (newDate) {
                      setState(() {
                        selectDate = newDate;
                      });
                    },
                    selectDate: selectDate,
                  ),
                  Divider(color: TColor.divider, height: 1),
                  SelectPicker(
                    allVal: List.generate(71, (index) => "${index + 130} cm"),
                    selectVal: selectHeight,
                    title: "Height",
                    didChange: (newVal) {
                      setState(() {
                        selectHeight = newVal;
                      });
                    },
                  ),
                  Divider(color: TColor.divider, height: 1),
                  SelectPicker(
                    allVal: List.generate(101, (index) => "${index + 30} kg"),
                    selectVal: selectWeight,
                    title: "Weight",
                    didChange: (newVal) {
                      setState(() {
                        selectWeight = newVal;
                      });
                    },
                  ),
                  Divider(color: TColor.divider, height: 1),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: media.width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            color: TColor.white, // White text color
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CupertinoSegmentedControl(
                          groupValue: isMale,
                          selectedColor: TColor.orange, // Orange selected color
                          unselectedColor: TColor.darkGrey, // Dark background for unselected
                          borderColor: TColor.orange, // Orange border color
                          children: const {
                            true: Text(" Male ", style: TextStyle(fontSize: 18)),
                            false: Text(" Female ", style: TextStyle(fontSize: 18)),
                          },
                          onValueChanged: (isMaleVal) {
                            setState(() {
                              isMale = isMaleVal;
                            });
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              child: RoundButton(
                title: "Start",
                onPressed: () {
                  // Uncomment the following lines for Firebase integration
                  // FirebaseFirestore.instance.collection('users').add({
                  //   'birthday': selectDate,
                  //   'height': selectHeight,
                  //   'weight': selectWeight,
                  //   'gender': isMale ? 'male' : 'female',
                  // });
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => false,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: index == 2 ? TColor.orange : TColor.gray.withOpacity(0.7), // Orange color for active, gray for inactive
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
