import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as developer;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _storage = FlutterSecureStorage();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _signUp() async {
    if (_usernameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty) {
      _showDialog('Error', 'All fields are required.');
      return;
    }

    // Simpan data pengguna
      String hashedPassword = hashPassword(_passwordController.text);
      await _storage.write(key: 'username', value: _usernameController.text);
      await _storage.write(key: 'password', value: hashedPassword);
    developer.log('User registered: ${_usernameController.text}');

    // Tampilkan pesan berhasil
    _showDialog('Pendaftaran Berhasil', 'Akun Anda telah berhasil dibuat.');

    // Navigasi ke halaman home setelah registrasi
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    });
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
    developer.log('SignUpPage: Building the sign-up page');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              Text(
                'Welcome!',
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
                controller: _emailController,
                label: 'Email or phone number',
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _signUp, // Panggil fungsi sign up
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 80, 98, 205)),
              ),
              SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman login
                  },
                  child: Text(
                    "Don’t have any account? Log In",
                    style: TextStyle(color: const Color.fromARGB(255, 80, 98, 205)),
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
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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