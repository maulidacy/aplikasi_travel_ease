class Destination {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double averageCost;
  final double rating;
  final List<String> tags;
  final String description;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.averageCost,
    required this.rating,
    required this.tags,
    required this.description,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      averageCost: json['averageCost'].toDouble(),
      rating: json['rating'].toDouble(),
      tags: List<String>.from(json['tags']),
      description: json['description'],
    );
  }
}

// lib/models/recommendation_request.dart
class RecommendationRequest {
  final String userId;
  final double budget;
  final List<String> preferences;

  RecommendationRequest({
    required this.userId,
    required this.budget,
    required this.preferences,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'budget': budget,
        'preferences': preferences,
      };
}