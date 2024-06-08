// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../menu/menu_view.dart';
import '../login/on_boarding_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  bool _verifyLogin(String username, String password) {
    return username == "example" && password == "password";
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Fitness App",
              style: TextStyle(
                color: TColor.orange, // Orange text color
                fontSize: 24, // Adjust font size as needed
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              style: TextStyle(color: TColor.white),
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(color: TColor.white),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              style: TextStyle(color: TColor.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: TColor.white),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            RoundButton(
              title: "Login",
              onPressed: () {
                String username = usernameController.text;
                String password = passwordController.text;

                // Uncomment the following lines for database integration
                // if (_verifyLogin(username, password)) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const MenuView()),
                //   );
                // } else {
                //   showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //       title: const Text("Error"),
                //       content: Text(
                //         "Incorrect username or password.",
                //         style: TextStyle(
                //           color: Colors.red, // Error text in red
                //         ),
                //       ),
                //       actions: <Widget>[
                //         TextButton(
                //           onPressed: () => Navigator.pop(context),
                //           child: const Text("OK"),
                //         ),
                //       ],
                //     ),
                //   );
                // }
                if (_verifyLogin(username, password)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuView()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(
                        "Incorrect username or password.",
                        style: TextStyle(
                          color: Colors.red, // Error text in red
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to OnBoardingView when "Register here" is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnBoardingView()),
                );
              },
              child: Text(
                "Don't have an account? Register here",
                style: TextStyle(
                  color: TColor.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
