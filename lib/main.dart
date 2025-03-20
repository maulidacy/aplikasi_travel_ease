import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'login_page.dart'; // Pastikan untuk mengimpor LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Builds the MaterialApp widget for the TravelEase application.
    /// This method sets up the application's main interface, including its
    /// title, theme, and home screen. The primarySwatch is set to blue, and
    /// the initial screen displayed is the SplashScreen.
    return MaterialApp(
      title: 'TravelEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    developer.log('SplashScreen: Building the splash screen');

    // Start the timer to navigate to the next screen after a delay
    Timer(Duration(seconds: 3), () {
      developer.log('SplashScreen: Navigating to the login page');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 91, 117),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.airplanemode_active,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'TravelEase',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}