import 'package:flutter/material.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../login/step3_view.dart';

class Step2View extends StatefulWidget {
  const Step2View({Key? key}) : super(key: key);

  @override
  State<Step2View> createState() => _Step2ViewState();
}

class _Step2ViewState extends State<Step2View> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.darkGrey, // Dark background color
      appBar: AppBar(
        backgroundColor: TColor.orange, // Dark background color
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
        title: const Text(
          "Step 1 of 2",
          style: TextStyle(
            color: Colors.white, // White text color
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Enter your details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // White text color
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: media.width * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    TextField(
                      controller: firstNameController,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white, // White text color
                      ),
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.width * 0.05),
                    TextField(
                      controller: lastNameController,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white, // White text color
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Last Name',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.width * 0.05),
                    TextField(
                      controller: usernameController,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white, // White text color
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.width * 0.05),
                    TextField(
                      controller: passwordController,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white, // White text color
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: media.width * 0.05),
                    TextField(
                      controller: confirmPasswordController,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white, // White text color
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // White text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: media.width * 0.1),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: RoundButton(
                  title: "Next",
                  onPressed: () {
                    if (_validateFields()) {
                    // Uncomment the following lines for Firebase integration
                    // FirebaseFirestore.instance.collection('users').add({
                    //   'first_name': firstNameController.text,
                    //   'last_name': lastNameController.text,
                    //   'username': usernameController.text,
                    //   'password': passwordController.text,
                    //   'confirm_password': confirmPasswordController.text,
                    // });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Step3View(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(
                            "Please fill all fields and ensure passwords match and contain at least one numeric character.",
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [1, 2, 3].map((pObj) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: 2 == pObj
                          ? TColor.primary
                          : TColor.white.withOpacity(0.7), // White with opacity
                      borderRadius: BorderRadius.circular(6),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    // Basic checks for field validation
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return false; // Any field is empty
    } else if (passwordController.text != confirmPasswordController.text) {
      return false; // Password and confirm password do not match
    } else {
      return passwordController.text.length > 6 &&
          RegExp(r'\d').hasMatch(passwordController.text);
    }
  }
}
