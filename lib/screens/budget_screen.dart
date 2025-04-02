import 'package:flutter/material.dart';

void main() {
  runApp(TravelBudgetApp());
}

class TravelBudgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BudgetScreen(budget: 0), // Pass a default budget for the initial run
    );
  }
}

class BudgetScreen extends StatefulWidget {
  final int budget; // New parameter for budget

  BudgetScreen({required this.budget}); // Constructor to accept budget
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<Map<String, dynamic>> destinations = [
    {"name": "Bali", "price": 2000000, "image": "https://source.unsplash.com/600x400/?bali"},
    {"name": "Yogyakarta", "price": 1500000, "image": "https://source.unsplash.com/600x400/?yogyakarta"},
    {"name": "Lombok", "price": 1800000, "image": "https://source.unsplash.com/600x400/?lombok"},
  ];
  List<Map<String, dynamic>> filteredDestinations = [];

  void searchDestinations() {
    final int budget = widget.budget; // Use the budget passed to filter destinations
    setState(() {
      filteredDestinations = destinations.where((dest) => dest['price'] <= budget).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rekomendasi Wisata")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan Budget (IDR)",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: searchDestinations,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredDestinations.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredDestinations.length,
                      itemBuilder: (context, index) {
                        final destination = filteredDestinations[index];
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(destination['image'], height: 150, width: double.infinity, fit: BoxFit.cover),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(destination['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text("Estimasi Biaya: IDR ${destination['price'].toString()}", style: TextStyle(color: Colors.grey[600])),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(child: Text("Masukkan budget untuk melihat rekomendasi.")),
            ),
          ],
        ),
      ),
    );
  }
}
