import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'package:learn_bloc_pattern/data_layer/models/hit.dart';

class ApiService {
  final _apiKey = '10064776-701d0c7395bbb04da4a9b73fc';
  final _host = 'https://pixabay.com/api';

  Future<List<Hit>> fetchHitLists([String query = '']) async {
    final url = '$_host/?key=$_apiKey&q=$query';
    final response = await http.get(url);
    final results = json.decode(response.body);
    final hits =
        results['hits'].map<Hit>((json) => Hit.fromJson(json)).toList();
    return hits;
  }
}
