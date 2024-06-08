import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class RunningView extends StatefulWidget {
  const RunningView({Key? key}) : super(key: key);

  @override
  _RunningViewState createState() => _RunningViewState();
}

class _RunningViewState extends State<RunningView> {
  Stream<StepCount>? _stepCountStream;
  Stream<PedestrianStatus>? _pedestrianStatusStream;
  int _stepCount = 0;
  double _distanceInKm = 0;
  int _caloriesBurned = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  /// Handle step count changed
  void onStepCount(StepCount event) {
    setState(() {
      _stepCount = event.steps;
      _caloriesBurned = calculateCaloriesBurned(_stepCount);
      _distanceInKm = calculateDistance(_stepCount);
    });
  }

  /// Calculate calories burned based on step count
  int calculateCaloriesBurned(int stepCount) {
    return (stepCount * 0.05).toInt();
  }

  /// Calculate distance traveled based on step count
  double calculateDistance(int stepCount) {
    return (stepCount * 0.8) / 1000;
  }

  /// Handle the error for step count stream
  void onStepCountError(error) {
    // Handle error
  }

  /// Handle the error for pedestrian status stream
  void onPedestrianStatusError(error) {
    // Handle error
  }

  Future<void> initPlatformState() async {
    // Initialize streams
    try {
      _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
      _stepCountStream = await Pedometer.stepCountStream;

      // Listen to streams and handle errors
      _stepCountStream!
          .listen(onStepCount)
          .onError(onStepCountError);

      _pedestrianStatusStream!
          .listen((_) {})
          .onError(onPedestrianStatusError);
    } catch (e) {
      // Handle initialization error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Running View',
          style: TextStyle(
            color: Colors.orange, // Orange text color
          ),
        ),
        backgroundColor: Colors.black, // Black app bar background
      ),
      backgroundColor: Colors.black, // Black background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Steps taken: $_stepCount',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Distance traveled: ${_distanceInKm.toStringAsFixed(2)} km',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text color
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Calories burned: $_caloriesBurned kcal',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white, // White text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
