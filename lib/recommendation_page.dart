import 'package:flutter/material.dart';
import 'models/destination.dart';
import 'models/recommendation_request.dart' as rec_request;
import 'services/destination_service.dart';
import 'destination_detail_page.dart';

class RecommendationPage extends StatefulWidget {
  final String userId;
  final double budget;

  const RecommendationPage({
    Key? key,
    required this.userId,
    required this.budget,
  }) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  late Future<List<Destination>> _recommendationsFuture;
  final DestinationService _destinationService = DestinationService();
  List<String> _selectedPreferences = [];

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  void _loadRecommendations() {
    setState(() {
      _recommendationsFuture = _destinationService.getRecommendations(
        rec_request.RecommendationRequest(
          userId: widget.userId,
          budget: widget.budget,
          preferences: _selectedPreferences,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Destinations'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: _showPreferenceFilter,
          ),
        ],
      ),
      body: FutureBuilder<List<Destination>>(
        future: _recommendationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No destinations found for your budget'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final destination = snapshot.data![index];
              return DestinationCard(
                destination: destination,
                onTap: () => _navigateToDetail(destination),
              );
            },
          );
        },
      ),
    );
  }

  void _showPreferenceFilter() {
    final allPreferences = [
      'Beach',
      'Mountain',
      'City',
      'Historical',
      'Adventure',
      'Relaxation'
    ];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Filter Preferences'),
              content: SingleChildScrollView(
                child: Column(
                  children: allPreferences.map((preference) {
                    return CheckboxListTile(
                      title: Text(preference),
                      value: _selectedPreferences.contains(preference),
                      onChanged: (selected) {
                        setState(() {
                          if (selected!) {
                            _selectedPreferences.add(preference);
                          } else {
                            _selectedPreferences.remove(preference);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _loadRecommendations();
                  },
                  child: Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _navigateToDetail(Destination destination) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DestinationDetailPage(destination: destination),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback onTap;

  const DestinationCard({
    Key? key,
    required this.destination,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                destination.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 4),
                  Text(destination.location),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(destination.rating.toStringAsFixed(1)),
                      Spacer(),
                      Text(
                        '\$${destination.averageCost.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text('/person'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    children: destination.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              labelStyle: TextStyle(fontSize: 12),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}