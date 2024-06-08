import 'package:flutter/material.dart';

import '../../common/color_extension.dart';
import '../weight/weight_view.dart';
import '../calorie_counter/calorie_counter.dart';
import '../menu/menu_view.dart';

class SupportPage extends StatelessWidget {
  void _showContactDialog(BuildContext context) {
    TextEditingController _textController = TextEditingController();


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: TColor.black,
          title: Text(
            'Contact Support',
            style: TextStyle(color: TColor.white),
          ),
          content: TextField(
            controller: _textController,
            maxLines: 4,
            style: TextStyle(color: TColor.white),
            decoration: InputDecoration(
              hintText: 'Type your message here...',
              hintStyle: TextStyle(color: TColor.gray),
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: TColor.orange),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Forward the message
                String message = _textController.text;
                print('Forwarding message: $message');
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: TColor.orange),
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.black,
      appBar: AppBar(
        backgroundColor: TColor.orange,
        title: Text(
          'Support',
          style: TextStyle(color: TColor.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to our support page!',
              style: TextStyle(color: TColor.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'If you have any questions, concerns, or feedback, please feel free to contact us. Our team is here to assist you.',
              style: TextStyle(color: TColor.white),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Information:',
              style: TextStyle(color: TColor.white, fontSize: 18),
            ),
            Text(
              'Phone: 123-456-7890\nEmail: support@example.com',
              style: TextStyle(color: TColor.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showContactDialog(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: Text('Contact Support'),
            ),
          ],
        ),
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
