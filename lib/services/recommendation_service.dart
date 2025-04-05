import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destination.dart';
import '../models/recommendation_request.dart' as rec_request;

class RecommendationService {
  static const String _baseUrl = 'https://api.travel-ease.com/v1';
  final String apiKey;

  RecommendationService({required this.apiKey});

  Future<List<Destination>> getRecommendations(rec_request.RecommendationRequest request) async {
    try {
      // 1. Panggil API eksternal untuk mendapatkan data mentah
      final externalData = await _fetchExternalData(request);
      
      // 2. Proses dengan model ML
      final recommendations = await _processWithML(externalData, request);
      
      return recommendations;
    } catch (e) {
      throw Exception('Failed to get recommendations: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> _fetchExternalData(rec_request.RecommendationRequest request) async {
    final url = Uri.parse('$_baseUrl/external/search');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey'
    };
    
    final body = jsonEncode({
      'budget': request.budget,
      'preferences': request.preferences,
      'user_id': request.userId
    });

    final response = await http.post(url, headers: headers, body: body);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('External API error: ${response.statusCode}');
    }
  }

  Future<List<Destination>> _processWithML(
      Map<String, dynamic> data, rec_request.RecommendationRequest request) async {
    final url = Uri.parse('$_baseUrl/ml/recommend');
    final headers = {'Content-Type': 'application/json'};
    
    final body = jsonEncode({
      'raw_data': data,
      'user_data': request.toJson()
    });

    final response = await http.post(url, headers: headers, body: body);
    
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return (result['recommendations'] as List)
          .map((json) => Destination.fromJson(json))
          .toList();
    } else {
      throw Exception('ML processing error: ${response.statusCode}');
    }
  }
}
