// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fitness_app/common_widget/setting_select_row.dart';
import 'package:fitness_app/common_widget/setting_switch_row.dart';
import 'package:fitness_app/view/settings/connect_view.dart';
import 'package:fitness_app/view/settings/select_language_view.dart';

import '../../common/color_extension.dart';
import '../weight/weight_view.dart';
import '../support/support.dart';
import '../calorie_counter/calorie_counter.dart';
import '../menu/menu_view.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List settingArr = [
    {"name": "Reminders", "type": "switch", "value": "false"},
    {"name": "Language", "type": "select", "value": "ENGLISH"},
    {"name": "Connected", "type": "select", "value": "Facebook"},
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
          "Settings",
          style: TextStyle(
              color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemBuilder: (context, index) {
            var tObj = settingArr[index] as Map? ?? {};

            if (tObj["type"] == "switch") {
              return SettingSwitchRow(
                  tObj: tObj,
                  onChanged: (newVal) {
                    settingArr[index]["value"] = newVal ? "true" : "false";
                    setState(() {});
                  });
            } else if (tObj["type"] == "select") {
              return SettingSelectRow(
                  tObj: tObj,
                  onPressed: () {
                    if (tObj["name"] == "Language") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SelectLanguageView(didSelect: (newVal) {})));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ConnectView(didSelect: (newVal) {})));
                    }
                  });
            } else {
              return Container();
            }
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.white,
              height: 1,
            );
          },
          itemCount: settingArr.length),
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
