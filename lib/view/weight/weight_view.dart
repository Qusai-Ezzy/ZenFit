import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import '../../common/color_extension.dart';
import '../support/support.dart';
import '../calorie_counter/calorie_counter.dart';
import '../menu/menu_view.dart';

class WeightView extends StatefulWidget {
  const WeightView({Key? key}) : super(key: key);

  @override
  _WeightViewState createState() => _WeightViewState();
}

class _WeightViewState extends State<WeightView> {
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  double _currentBMI = 25.0; // Placeholder value for current BMI
  String _heightError = ''; // Error message for height input
  String _weightError = ''; // Error message for weight input

  @override
  void initState() {
    super.initState();
    // Uncomment the following line to fetch BMI from Firebase
    // fetchBMI();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: TColor.black,
        appBar: AppBar(
          backgroundColor: TColor.primary,
          title: Text('BMI Calculator'),
          centerTitle: true,
          elevation: 0.1,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Calculator'),
              Tab(text: 'Records'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCalculatorTab(),
            _buildRecordsTab(),
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
                      MaterialPageRoute(
                          builder: (context) => CalorieCounterPage()),
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
      ),
    );
  }

  Widget _buildCalculatorTab() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Current BMI: ${_currentBMI.toStringAsFixed(2)}',
                style: TextStyle(color: TColor.white, fontSize: 24),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: TColor.white),
            decoration: InputDecoration(
              labelText: 'Height (cm)',
              labelStyle: TextStyle(color: TColor.white),
              errorText: _heightError.isNotEmpty
                  ? _heightError
                  : null, // Add error text
              border: OutlineInputBorder(
                borderSide: BorderSide(color: TColor.white),
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (_isAlphabetic(value)) {
                  // Check if alphabets are entered
                  _heightError =
                      'Please enter valid height'; // Set error message
                } else {
                  _heightError = ''; // Clear error message if valid input
                }
              });
            },
          ),
          SizedBox(height: 20),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: TColor.white),
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              labelStyle: TextStyle(color: TColor.white),
              errorText: _weightError.isNotEmpty
                  ? _weightError
                  : null, // Add error text
              border: OutlineInputBorder(
                borderSide: BorderSide(color: TColor.white),
              ),
            ),
            onChanged: (value) {
              setState(() {
                if (_isAlphabetic(value)) {
                  // Check if alphabets are entered
                  _weightError =
                      'Please enter valid weight'; // Set error message
                } else {
                  _weightError = ''; // Clear error message if valid input
                }
              });
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _calculateBMI();
              // Uncomment the following line to store BMI in Firebase
              // storeBMI(_currentBMI);
            },
            child: Text('Calculate BMI'),
            style: ElevatedButton.styleFrom(
              backgroundColor: TColor.primary,
              textStyle: TextStyle(color: TColor.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordsTab() {
    return Center(
      child: Text(
        'BMI Records',
        style: TextStyle(color: TColor.white, fontSize: 24),
      ),
    );
  }

  // Widget _buildRecordsTab() {
  //   return FutureBuilder(
  //     future: fetchBMIRecords(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       } else if (snapshot.hasError) {
  //         return Center(child: Text('Error: ${snapshot.error}'));
  //       } else if (snapshot.hasData) {
  //         List<double> bmiRecords = snapshot.data as List<double>;
  //         return ListView.builder(
  //           itemCount: bmiRecords.length,
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               title: Text('BMI Record ${bmiRecords.length - index}'),
  //               subtitle: Text('BMI: ${bmiRecords[index].toStringAsFixed(2)}'),
  //             );
  //           },
  //         );
  //       } else {
  //         return Center(child: Text('No records found'));
  //       }
  //     },
  //   );
  // }

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        _currentBMI = bmi;
      });
    } else {
      // Handle invalid input
      setState(() {
        _currentBMI = 0;
      });
    }
  }

  bool _isAlphabetic(String value) {
  final RegExp regex = RegExp(r'[a-zA-Z]');
  return regex.hasMatch(value);
}

  // Uncomment the following code when Firebase is set up
  // void storeBMI(double bmi) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('currentUserId') // Replace 'currentUserId' with the actual user ID
  //       .set({
  //     'bmi': bmi,
  //     'timestamp': Timestamp.now(), // Optionally add a timestamp
  //   });
  // }

  // Future<List<double>> fetchBMIRecords() async {
  //   // Replace 'currentUserId' with the actual user ID
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('currentUserId')
  //       .collection('bmiRecords')
  //       .orderBy('timestamp', descending: true)
  //       .limit(10)
  //       .get();

  //   List<double> bmiRecords = [];
  //   querySnapshot.docs.forEach((document) {
  //     bmiRecords.add(document.data()['bmi'] as double);
  //   });

  //   return bmiRecords;
  // }

}
