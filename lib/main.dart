import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'login_page.dart';
import 'helpers/database_helper.dart';
import 'models/user.dart';
import 'recommendation_page.dart'; // Import halaman rekomendasi
import 'models/destination.dart'; // Import model destinasi

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => HomePage(),
        '/recommendations': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return RecommendationPage(
            userId: args['userId'],
            budget: args['budget'],
          );
        },
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    developer.log('SplashScreen: Building the splash screen');

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  double _budget = 1000; // Default budget, bisa diubah dengan input user
  String? _userId; // ID user dari login

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    // Contoh: Ambil data user dari database
    // Dalam implementasi nyata, ini bisa dari SharedPreferences atau state management
    List<User> users = await _dbHelper.getUsers();
    if (users.isNotEmpty) {
      setState(() {
        _userId = users.first.id.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TravelEase'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Travel Budget',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$${_budget.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 10),
                    Slider(
                      value: _budget,
                      min: 100,
                      max: 10000,
                      divisions: 99,
                      label: _budget.toStringAsFixed(0),
                      onChanged: (value) {
                        setState(() {
                          _budget = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    Icons.place,
                    'Recommendations',
                    Colors.blue,
                    () {
                      if (_userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please login first')),
                        );
                        return;
                      }
                      Navigator.pushNamed(
                        context,
                        '/recommendations',
                        arguments: {
                          'userId': _userId!,
                          'budget': _budget,
                        },
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.attach_money,
                    'Budget Tracker',
                    Colors.green,
                    () {
                      // TODO: Implement budget tracker
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feature coming soon!')),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.list,
                    'My Trips',
                    Colors.orange,
                    () {
                      // TODO: Implement my trips
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feature coming soon!')),
                      );
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.settings,
                    'Settings',
                    Colors.purple,
                    () {
                      // TODO: Implement settings
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feature coming soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    _users = await _dbHelper.getUsers();
    setState(() {});
  }

  void _addUser() async {
    await _dbHelper.insertUser(User(name: 'John Doe'));
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_users[index].name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: Icon(Icons.add),
      ),
    );
  }
}