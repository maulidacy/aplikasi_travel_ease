import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'login_page.dart';
import 'home_page.dart';
import 'helpers/database_helper.dart';
import 'models/user.dart';
import 'recommendation_page.dart';
import 'screens/budget_screen.dart';

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
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/recommendations': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          if (args['userId'] == null || args['budget'] == null) {
            return Center(child: Text('Invalid arguments provided'));
          }
          return RecommendationPage(
            userId: args['userId'].toString(),
            budget: double.parse(args['budget'].toString()),
          );
        },
        '/budget': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map?;
          return BudgetScreen(
            budget: args != null ? args['budget']?.toInt() ?? 0 : 0,
          );
        },
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
  double _budget = 1000; // Default budget
  String? _userId; // User ID from login

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    List<User> users = await _dbHelper.getUsers();
    if (users.isNotEmpty) {
      setState(() {
        _userId = users.first.uid;
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
                // Removed reference to undefined UserScreen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User profile feature coming soon')),
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
                      if (_userId != null) {
                        Navigator.pushNamed(
                          context,
                          '/recommendations',
                          arguments: {
                            'userId': _userId!,
                            'budget': _budget.toString(),
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User ID is not available')),
                        );
                      }
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.attach_money,
                    'Budget Tracker',
                    Colors.green,
                    () {
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