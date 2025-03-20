import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Tambahkan logika untuk notifikasi
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for travel based on budget...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(width: 1),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // New Place Section
              Text(
                'New Place',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPlaceCard('assets/mountain.jpg', 'Mountain View'),
                    _buildPlaceCard('assets/beach.jpg', 'Beach Resort'),
                    _buildPlaceCard('assets/city.jpg', 'City Tour'),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Popular Hotel Section
              Text(
                'Popular Hotel',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  _buildHotelCard('Para Hotel', 'Venice', 'assets/hotel1.jpg'),
                  SizedBox(height: 10),
                  _buildHotelCard('Heven Hotel', 'Venice', 'assets/hotel2.jpg'),
                ],
              ),
              SizedBox(height: 20),

              // Recommended Section
              Text(
                'Recommended',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Tambahkan konten rekomendasi di sini
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceCard(String imagePath, String placeName) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Center(
        child: Text(
          placeName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildHotelCard(String hotelName, String location, String imagePath) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hotelName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(location),
            ],
          ),
        ],
      ),
    );
  }
}
