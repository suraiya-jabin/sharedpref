import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World Shared Preferences',
      home: HelloWorldScreen(),
    );
  }
}

class HelloWorldScreen extends StatefulWidget {
  @override
  _HelloWorldScreenState createState() => _HelloWorldScreenState();
}

class _HelloWorldScreenState extends State<HelloWorldScreen> {
  String message = "Hello World"; 

  @override
  void initState() {
    super.initState();
    _loadMessage(); 
  }


  Future<void> _loadMessage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      message = prefs.getString('savedMessage') ?? "Hello World";
    });
  }

  // Save the message to SharedPreferences
  Future<void> _saveMessage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedMessage', message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  message = "Hello, Flutter!";
                });
                _saveMessage();
              },
              child: Text('Change Message'),
            ),
          ],
        ),
      ),
    );
  }
}
