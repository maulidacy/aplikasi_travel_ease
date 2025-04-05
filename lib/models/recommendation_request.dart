
class RecommendationRequest {
  final String userId;
  final double budget;
  final List<String> preferences;
  final String? location; // Lokasi user (opsional)
  final DateTime? travelDate; // Tanggal perjalanan (opsional)
  final int? duration; // Durasi perjalanan dalam hari (opsional)

  RecommendationRequest({
    required this.userId,
    required this.budget,
    required this.preferences,
    this.location,
    this.travelDate,
    this.duration,
  });

  // Konversi ke format JSON untuk dikirim ke API
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'budget': budget,
      'preferences': preferences,
      'location': location,
      'travelDate': travelDate?.toIso8601String(),
      'duration': duration,
    };
  }

  // Factory method untuk membuat objek dari JSON
  factory RecommendationRequest.fromJson(Map<String, dynamic> json) {
    return RecommendationRequest(
      userId: json['userId'],
      budget: json['budget'].toDouble(),
      preferences: List<String>.from(json['preferences']),
      location: json['location'],
      travelDate: json['travelDate'] != null ? DateTime.parse(json['travelDate']) : null,
      duration: json['duration'],
    );
  }

  // Method untuk membuat copy dengan beberapa perubahan
  RecommendationRequest copyWith({
    String? userId,
    double? budget,
    List<String>? preferences,
    String? location,
    DateTime? travelDate,
    int? duration,
  }) {
    return RecommendationRequest(
      userId: userId ?? this.userId,
      budget: budget ?? this.budget,
      preferences: preferences ?? this.preferences,
      location: location ?? this.location,
      travelDate: travelDate ?? this.travelDate,
      duration: duration ?? this.duration,
    );
  }

  @override
  String toString() {
    return 'RecommendationRequest{userId: $userId, budget: $budget, preferences: $preferences, location: $location, travelDate: $travelDate, duration: $duration}';
  }

  // Method untuk validasi data
  bool isValid() {
    return userId.isNotEmpty && budget > 0 && preferences.isNotEmpty;
  }
}