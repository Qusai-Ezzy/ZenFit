// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fitness_app/view/tips/tips_details_view.dart';

import '../../common/color_extension.dart';
import '../../common_widget/tip_row.dart';
import '../weight/weight_view.dart';
import '../support/support.dart';
import '../calorie_counter/calorie_counter.dart';
import '../menu/menu_view.dart';

class TipsView extends StatefulWidget {
  const TipsView({super.key});

  @override
  State<TipsView> createState() => _TipsViewState();
}

class _TipsViewState extends State<TipsView> {
  List tipsArr = [
    {"name": "About Traning"},
    {"name": "How to weight loss ?"},
    {"name": "How the Calorie Calcuator Works "},
    {"name": "How to Track Progress"},
    {"name": "Not Gaining Muscle Mass"},
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.black,
      appBar: AppBar(
        backgroundColor: TColor.primary,
        centerTitle: true,
        elevation: 0.1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/img/black_white.png",
              width: 25,
              height: 25,
            )),
        title: Text(
          "Tips",
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) {
            var tObj = tipsArr[index] as Map? ?? {};
            return TipRow(
              tObj: tObj,
              isActive: index == 0,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TipsDetailView(
                              tObj: tObj,
                            )));
              },
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.white, // Update color to use TColor
              height: 1,
            );
          },
          itemCount: tipsArr.length),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => WorkoutView()),
                //   );
                // },
                child: Image.asset("assets/img/running.png",
                    width: 25, height: 25),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalorieCounterPage()),
                  );
                },
                child: Image.asset(
                  "assets/img/restaurant.png",
                  width: 25,
                  height: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuView()),
                  );
                },
                child: Image.asset(
                  "assets/img/house-chimney(1).png",
                  width: 25,
                  height: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeightView()),
                  );
                },
                child: Image.asset(
                  "assets/img/ranking-podium-empty.png",
                  width: 25,
                  height: 25,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SupportPage()),
                  );
                },
                child: Image.asset(
                  "assets/img/question.png",
                  width: 25,
                  height: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
