import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_finder/models/location.dart';
import '../http_exception/http_exception.dart';

class HttpClient {
  final userKey = '7b5cbf6625aa3271b3a4a026d265a525';
  final baseUrl = 'https://zomato.com/api/v2.1/locations';

  Future<List<Location>> getLocations(String query) async {
    try {
        final response = await http.get(
            'https://zomato.com/api/v2.1/locations?query=$query',
            headers: {
              'user-key': '7b5cbf6625aa3271b3a4a026d265a525',
            });

        final convertedData = json.decode(response.body);
        final status = convertedData['status'] as dynamic;

        if (status == 'success') {
          final locations = convertedData['location_suggestions']
              as List<dynamic>;
          final suggestedLocations = locations.map((location) {
            return Location.fromJson(location);
          }).toList();
         return suggestedLocations;
        } else {
          return [];
        }
      } catch (error) {
        throw HttpException(error.toString());
      }
  }
}