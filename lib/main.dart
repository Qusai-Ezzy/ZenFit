import 'package:flutter/material.dart';
// import 'package:workout_fitness/view/login/on_boarding_view.dart';
// import 'package:fitness_app/view/menu/menu_view.dart';

import 'common/color_extension.dart';
// import 'view/login/step3_view.dart';
// import 'view/login/step2_view.dart';
import 'view/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSeed(seedColor: TColor.orange),
        useMaterial3: false,
      ),
      // home: const MenuView(),
      // home: const Step3View(),
      home: const LoginView(),
    );
  }
}
