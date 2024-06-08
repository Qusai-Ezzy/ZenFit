// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../common/color_extension.dart';
import '../weight/weight_view.dart';
import '../support/support.dart';
import '../calorie_counter/calorie_counter.dart';
import '../menu/menu_view.dart';

class HeartView extends StatefulWidget {
  const HeartView({Key? key}) : super(key: key);

  @override
  State<HeartView> createState() => _HeartViewState();
}

class _HeartViewState extends State<HeartView> {
  int heartRate = 110; // Heart rate value, you can replace it with actual data

  String determineHeartRateStatus(int heartRate) {
    if (heartRate < 60) {
      return "  Low";
    } else if (heartRate >= 60 && heartRate <= 100) {
      return "  Normal";
    } else if (heartRate > 100 && heartRate <= 120) {
      return "  High";
    } else {
      return "  Dangerous";
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    
    // Input values for blood pressure and body temperature
    int bloodPressure = 120;
    double bodyTemperature = 37.0;

    // Function to determine blood pressure status
    String determineBloodPressureStatus(int bloodPressure) {
      if (bloodPressure < 90) {
        return "Low";
      } else if (bloodPressure >= 90 && bloodPressure <= 120) {
        return "Normal";
      } else if (bloodPressure > 120 && bloodPressure <= 140) {
        return "High";
      } else {
        return "Dangerous";
      }
    }

    // Function to determine body temperature status
    String determineTemperatureStatus(double temperature) {
      if (temperature < 36.0) {
        return "Low";
      } else if (temperature >= 36.0 && temperature <= 37.0) {
        return "Normal";
      } else if (temperature > 37.0 && temperature <= 38.0) {
        return "High";
      } else {
        return "Dangerous";
      }
    }

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
          ),
        ),
        title: Text(
          "Fitness Application",
          style: TextStyle(
            color: TColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
            // Adjust the height of this SizedBox as needed to move content lower
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: TColor.darkGrey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Image.asset(
                    "assets/img/heart(2).png", // Replace with your image path
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Heart Rate",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25), // Added spacing
          SizedBox(width: 10),
          Column(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$heartRate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " bpm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          determineHeartRateStatus(heartRate),
                          // Determine status dynamically
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 230), // Added spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: media.width * 0.4,
                    height: 200,
                    decoration: BoxDecoration(
                      color: TColor.darkGrey, // Change color as needed
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/drop.png", // Replace with your image path
                          width: 40,
                          height: 40,
                          color: Colors.red, // Optional: You can apply color to the image
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Blood Pressure",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$bloodPressure mmHg",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          determineBloodPressureStatus(bloodPressure),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: media.width * 0.4,
                    height: 200,
                    decoration: BoxDecoration(
                      color: TColor.darkGrey, // Change color as needed
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/temperature-high.png", // Replace with your image path
                          width: 40,
                          height: 40,
                          color: Colors.red, // Optional: You can apply color to the image
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Body Temp.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$bodyTemperature °C",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          determineTemperatureStatus(bodyTemperature),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
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
