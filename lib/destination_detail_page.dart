import 'package:flutter/material.dart';
import 'models/destination.dart';

class DestinationDetailPage extends StatelessWidget {
  final Destination destination;

  const DestinationDetailPage({
    Key? key,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destination.name),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        destination.location,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    destination.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 24),
                  _buildInfoSection(context),
                  SizedBox(height: 24),
                  _buildBudgetSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            SizedBox(width: 8),
            Text('${destination.rating} Rating'),
          ],
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: destination.tags
              .map((tag) => Chip(
                    label: Text(tag),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildBudgetSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Estimation',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        ListTile(
          leading: Icon(Icons.hotel, color: Colors.blue),
          title: Text('Accommodation'),
          trailing: Text('\$${(destination.averageCost * 0.5).toStringAsFixed(0)}'),
        ),
        ListTile(
          leading: Icon(Icons.airplanemode_active, color: Colors.green),
          title: Text('Transportation'),
          trailing: Text('\$${(destination.averageCost * 0.3).toStringAsFixed(0)}'),
        ),
        ListTile(
          leading: Icon(Icons.restaurant, color: Colors.orange),
          title: Text('Food & Activities'),
          trailing: Text('\$${(destination.averageCost * 0.2).toStringAsFixed(0)}'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.attach_money, color: Colors.purple),
          title: Text(
            'Total Estimated Cost',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            '\$${destination.averageCost.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(Icons.favorite_border),
              label: Text('Save'),
              onPressed: () {
                // TODO: Implement save functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Destination saved!')),
                );
              },
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              icon: Icon(Icons.add),
              label: Text('Add to Trip'),
              onPressed: () {
                // TODO: Implement add to trip functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to your trip plan!')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}