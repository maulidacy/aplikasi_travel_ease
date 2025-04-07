import 'package:flutter/material.dart';
import 'sign_up_page.dart';
import 'home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _storage = FlutterSecureStorage();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _login() async {
    String? storedUsername = await _storage.read(key: 'username');
    String? storedPassword = await _storage.read(key: 'password');

    String hashedInputPassword = hashPassword(_passwordController.text);

    if (_usernameController.text == storedUsername &&
        hashedInputPassword == storedPassword) {
      // Login berhasil
      developer.log('Login berhasil');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ), // Navigasi ke HomePage
      );
    } else {
      // Login gagal
      developer.log('Login gagal');
      _showDialog('Login Gagal', 'Username atau password salah.');
    }
  }

  // Setelah login berhasil
void _loginSuccess() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}

  // Fungsi untuk menampilkan dialog
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    developer.log('LoginPage: Building the login page');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(Icons.airplane_ticket, size: 64, color: const Color.fromARGB(255, 80, 98, 205)),
                    SizedBox(height: 8),
                    Text(
                      'TravelEase',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 80, 98, 205),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Welcome Message
              Text(
                'Welcome Back!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'Please enter your account here',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 40),
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password logic
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: const Color.fromARGB(255, 80, 98, 205),),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login, // Panggil fungsi login
                child: Text('Log In'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 80, 98, 205)),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Don’t have any account? Sign Up",
                    style: TextStyle(color: const Color.fromARGB(255, 80, 98, 205),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30), // Radius sudut
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueGrey),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                  : null,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none, // Menghilangkan border
        ),
      ),
    );
  }
}