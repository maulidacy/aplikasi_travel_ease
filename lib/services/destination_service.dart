// lib/services/destination_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/destination.dart';
import '../models/recommendation_request.dart' as rec_request;

class DestinationService {
  static const String _baseUrl = 'https://your-backend-api.com';

  Future<List<Destination>> getRecommendations(
      rec_request.RecommendationRequest request) async {
    // Validate request
    if (!request.isValid()) {
      throw ArgumentError('Invalid recommendation request: $request');
    }

    final url = Uri.parse('$_baseUrl/api/recommendations');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(request.toJson());

    try {
      if (kDebugMode) {
        print('Sending recommendation request: $body');
      }
      
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      ).timeout(const Duration(seconds: 10));

      if (kDebugMode) {
        print('Received response: ${response.statusCode} ${response.body}');
      }

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData is! Map || responseData['data'] is! List) {
          throw const FormatException('Invalid response format');
        }
        
        final List<dynamic> data = responseData['data'];
        return data.map((json) => Destination.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load recommendations (${response.statusCode})',
        );
      }
    } on FormatException catch (e) {
      throw FormatException('Invalid response format: ${e.message}');
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get recommendations: ${e.toString()}');
    }
  }

  // Untuk pencarian manual (jika diperlukan)
  Future<List<Destination>> searchDestinations(
      String query, double maxBudget) async {
    final url = Uri.parse('$_baseUrl/api/search?query=$query&maxBudget=$maxBudget');
    
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Destination.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search destinations');
    }
  }
}