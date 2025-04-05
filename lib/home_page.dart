import 'package:aplikasi_travel_ease/screens/budget_screen.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // 0 for Travel, 1 for Tracker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Recommender'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Tambahkan logika untuk notifikasi
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Button for Travel and Tracker
            ToggleButtons(
              isSelected: [_selectedIndex == 0, _selectedIndex == 1],
              onPressed: (index) {
                setState(() {
                  _selectedIndex = index;
                });

                // Navigasi ke halaman yang sesuai
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TravelPage()),
                  );
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpenseTrackerPage(),
                    ),
                  );
                }
              },
              color: Colors.grey,
              selectedColor: Colors.black,
              fillColor: Colors.white,
              borderRadius: BorderRadius.circular(30),
              borderColor: Colors.grey,
              selectedBorderColor: Colors.blueAccent,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Travel'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Tracker'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari destinasi berdasarkan anggaran...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onTap: () {
                _showBudgetInputDialog(context);
              },
            ),
            SizedBox(height: 20),
            Text(
              'Wisata Terbaru',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // New Place Section
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDestinationCard(
                    'Candi Prambanan',
                    'assets/prambanan.jpg',
                  ),
                  _buildDestinationCard('Venice', 'assets/venice.jpg'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Popular Wisata',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Popular Wisata Section
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildHotelCard(
                    'Para Hotel',
                    'Venice',
                    'assets/para_hotel.jpg',
                  ),
                  _buildHotelCard(
                    'Heaven Hotel',
                    'Venice',
                    'assets/heaven_hotel.jpg',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rekomendasi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Placeholder for recommendations
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('Bali'),
                    subtitle: Text('Recommended based on your preferences'),
                  ),
                  ListTile(
                    title: Text('Venice'),
                    subtitle: Text('Recommended based on your preferences'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build destination card
  Widget _buildDestinationCard(String title, String imagePath) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }

  // Function to build hotel card
  Widget _buildHotelCard(String title, String location, String imagePath) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.black54,
            ),
          ),
          Text(
            location,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              backgroundColor: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Function to show budget input dialog
  void _showBudgetInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String budget = '';
        return AlertDialog(
          title: Text('Input Your Budget'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter your budget'),
            onChanged: (value) {
              budget = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Handle budget input
                Navigator.of(context).pop();
                // Navigate to BudgetScreen with the entered budget
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            BudgetScreen(budget: int.tryParse(budget) ?? 0),
                  ),
                );
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

// Placeholder for TravelPage
class TravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Travel Page')),
      body: Center(child: Text('Welcome to Travel Page')),
    );
  }
}

// Placeholder for ExpenseTrackerPage
class ExpenseTrackerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: Center(child: Text('Welcome to Expense Tracker Page')),
    );
  }
}
