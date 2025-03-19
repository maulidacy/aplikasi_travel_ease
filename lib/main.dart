import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    // Start the timer to navigate to the next screen after a delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 91, 117), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Image
            Icon(
              Icons.airplanemode_active, // Replace with your logo
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

//======================== LOGIN PAGE =======================
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or Image
              Container(
                alignment: Alignment.center,
                child: Text(
                  'TravelEase',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Username Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Email or Phone Number Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email or phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Password Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                ),
              ),
              SizedBox(height: 16),
              // Login Link
              Center(
                child: Text(
                  "Don't have any account? Log In",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}import 'dart:developer' as developer;

// ...

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
      backgroundColor: const Color.fromARGB(255, 59, 91, 117), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Image
            Icon(
              Icons.airplanemode_active, // Replace with your logo
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

//======================== LOGIN PAGE =======================
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    developer.log('LoginPage: Building the login page');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo or Image
              Container(
                alignment: Alignment.center,
                child: Text(
                  'TravelEase',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Username Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Email or Phone Number Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email or phone number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              // Password Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility),
                ),
                obscureText: true,
              ),
              SizedBox(height: 24),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  developer.log('LoginPage: Sign up button pressed');
                  // Handle sign-up logic
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                ),
              ),
              SizedBox(height: 16),
              // Login Link
              Center(
                child: Text(
                  "Don't have any account? Log In",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}