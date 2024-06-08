// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import '../weight/weight_view.dart';
import '../support/support.dart';
import '../meal_plan/meal_plan_view_2.dart';
import '../menu/menu_view.dart';
import '../../common/color_extension.dart';


class CalorieCounterPage extends StatefulWidget {
  const CalorieCounterPage({Key? key}) : super(key: key);

  @override
  _CalorieCounterPageState createState() => _CalorieCounterPageState();
}

class _CalorieCounterPageState extends State<CalorieCounterPage> {
  late List<List<dynamic>> _caloriesData;
  late List<String>? _foodCategories;
  late List<String>? _filteredFoodItems;
  late List<String> _selectedItems = [];
  late TextEditingController _searchController;
  late String _selectedCategory;
  late String _selectedFood;
  late int _dailyCalorieLimit;
  late TextEditingController _dailyCalorieLimitController;
  double _weightGrams = 100;
  int _calories = 0;
  int _totalCalories = 0;
  bool _filteredFoodVisible = false;

  @override
  void initState() {
    super.initState();
    _loadCaloriesData();
    _searchController = TextEditingController();
    _dailyCalorieLimitController = TextEditingController();
    _selectedCategory = 'All Categories';
    _selectedFood = '';
    _foodCategories = [];
    _filteredFoodItems = [];
    _dailyCalorieLimit = 0; // Initialize daily calorie limit to 0
    _totalCalories = 0; // Initialize total calories
  }

  Future<void> _loadCaloriesData() async {
    final String data =
        await rootBundle.loadString('assets/datasets/calories.csv');
    _caloriesData = CsvToListConverter().convert(data);
    _foodCategories = _extractFoodCategories(_caloriesData);
    _filteredFoodItems =
        _caloriesData.map((row) => row[1]).toList().cast<String>();
  }


  List<String>? _extractFoodCategories(List<List<dynamic>> data) {
    Set<String> categories = Set();
    for (var i = 0; i < data.length; i++) {
      categories.add(data[i][0]);
    }
    return categories.toList()..sort();
  }

  void _filterFoodByCategory(String category) {
    setState(() {
      if (category == 'All Categories') {
        _filteredFoodItems =
            _caloriesData.map((row) => row[1]).toList().cast<String>();
      } else {
        _filteredFoodItems = _caloriesData
            .where((row) => row[0] == category)
            .map((row) => row[1])
            .toList()
            .cast<String>();
      }
      _selectedCategory = category;
    });
  }

  void _searchFood(String query) {
    setState(() {
      _filteredFoodItems = _caloriesData
          .where((row) =>
              row[1].toString().toLowerCase().contains(query.toLowerCase()))
          .map((row) => row[1])
          .toList()
          .cast<String>();
      _selectedCategory = 'All Categories';
    });
  }

  void _calculateCalories() {
    setState(() {
      _calories = _caloriesData
              .firstWhere((row) => row[1] == _selectedFood, orElse: () => [])
              .isNotEmpty
          ? ((_weightGrams / 100) *
                  double.parse(_caloriesData
                      .firstWhere((row) => row[1] == _selectedFood)
                      .last
                      .toString()
                      .replaceAll(RegExp(r'[^0-9.]'), '')))
              .round()
          : 0;
      _totalCalories += _calories;
      _selectedItems.add('$_selectedFood: $_weightGrams grams');
    });
      _checkDailyLimitExceeded(); 
  }

  void _checkDailyLimitExceeded() {
  if (_totalCalories > _dailyCalorieLimit) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Daily Calorie Limit Exceeded'),
          content: Text('Your total calorie intake has exceeded the daily limit. Sticking to your Intake can be hard, consider filling but low calorie foods to fulfil your cravings'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

  int _calculateRemovedItemCalories(int index) {
    String selectedItem = _selectedItems[index];
    String selectedFood = selectedItem.split(':')[0];
    double weightGrams = double.parse(selectedItem.split(':')[1].split(' ')[1]);
    int calories = _caloriesData
            .firstWhere((row) => row[1] == selectedFood, orElse: () => [])
            .isNotEmpty
        ? ((_weightGrams / 100) *
                double.parse(_caloriesData
                    .firstWhere((row) => row[1] == selectedFood)
                    .last
                    .toString()
                    .replaceAll(RegExp(r'[^0-9.]'), '')))
            .round()
        : 0;
    return (calories * (weightGrams / 100)).round();
  }

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
        "Calorie Counter",
        style: TextStyle(
            color: TColor.white, fontSize: 20, fontWeight: FontWeight.w700),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            dropdownColor: TColor.black,
            items: _foodCategories != null
                ? ['All Categories', ..._foodCategories!].map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(color: TColor.white), // Set text color to white
                      ),
                    );
                  }).toList()
                : [], // Check if _foodCategories is not null
            onChanged: (value) {
              _filterFoodByCategory(value!);
              // Call _searchFood if user selects 'All Categories'
              if (value == 'All Categories') {
                _searchFood(_searchController.text);
              }
            },
          ),
          TextField(
            controller: _searchController,
            style: TextStyle(color: TColor.white),
            decoration: InputDecoration(
              labelText: 'Search Food',
              labelStyle: TextStyle(color: TColor.white),
              suffixIcon: IconButton(
                icon: Icon(Icons.search, color: TColor.white),
                onPressed: () {
                  _searchFood(_searchController.text);
                  // Call _filterFoodByCategory with 'All Categories' if search is empty
                  if (_searchController.text.isEmpty) {
                    _filterFoodByCategory('All Categories');
                  }
                },
              ),
            ),
            onChanged: (value) {
              setState(() {
                // Update the visibility state based on whether the search box is empty or not
                _filteredFoodVisible = value.isNotEmpty;
                _searchFood(value); // Update the filtered food items
              });
            },
          ),
          Expanded(
            child: Visibility(
              visible: _filteredFoodVisible, // Use the visibility state here
              child: ListView.builder(
                itemCount: _filteredFoodItems != null
                    ? _filteredFoodItems!.length
                    : 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _filteredFoodItems![index],
                      style: TextStyle(color: TColor.white),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedFood = _filteredFoodItems![index];
                      });
                      _showWeightInputDialog();
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               Text(
                    'Calories: $_calories',
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Total Calories: $_totalCalories',
                    style: TextStyle(
                      color: TColor.white,
                      fontSize: 20,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Daily Calorie Limit: $_dailyCalorieLimit',
                        style: TextStyle(
                          color: TColor.white,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: TColor.white),
                        onPressed: () => _showDailyCalorieLimitInputDialog(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _recordCaloriesLog(_totalCalories),
      child: Icon(Icons.add),
      backgroundColor: Colors.orange, // Adjust FAB color
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
                  MaterialPageRoute(builder: (context) => MealPlanView2()),
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


  void _showWeightInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Weight (grams)'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _weightGrams = double.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _calculateCalories();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void _showDailyCalorieLimitInputDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter Daily Calorie Limit'),
        content: TextFormField(
          keyboardType: TextInputType.number,
          controller: _dailyCalorieLimitController,
          decoration: InputDecoration(
            hintText: 'Enter daily calorie limit',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _dailyCalorieLimit = int.tryParse(_dailyCalorieLimitController.text) ?? 0;
              });
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
}


void _recordCaloriesLog(int _totalCalories) async {
  // Get the current date
  String currentDate = DateTime.now().toString();
  // Format the total calories and date into a log entry
  String logEntry = '$_totalCalories,$currentDate\n';

  // Print the log entry for debugging
  print('Log Entry: $logEntry');

  // Define the file path
  String filePath = 'assets/datasets/calorieLog.csv';
  File file = File(filePath);

  // Check if the file exists
  bool fileExists = await file.exists();
  if (!fileExists) {
    print('File does not exist. Creating file...');
    await file.create();
  }

  // Write the log entry to the calorie log file
  try {
    await file.writeAsString(logEntry, mode: FileMode.append);
    print('Log entry written successfully.');
  } catch (e) {
    print('Error writing to file: $e');
  }
}

