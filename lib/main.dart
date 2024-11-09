import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'InitialPages/SignUpScreen.dart';
import 'InitialPages/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InitialScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool? _isSignedUp; // Track if the user is signed up or not

  @override
  void initState() {
    super.initState();
    _checkSignUpStatus();
  }

  // Check if user is signed up
  Future<void> _checkSignUpStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedUp =
        prefs.getBool('isSignedUp') ?? false; // Default to false if not set
    setState(() {
      _isSignedUp = isSignedUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    // While checking the sign-up status, show loading spinner
    if (_isSignedUp == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Navigate based on sign-up status
    return _isSignedUp!
        ? MyHomePage(
            username: 'Cookie',
          ) // If signed up, navigate to home page
        : SignUpScreen(); // If not signed up, navigate to sign-up screen
  }
}
