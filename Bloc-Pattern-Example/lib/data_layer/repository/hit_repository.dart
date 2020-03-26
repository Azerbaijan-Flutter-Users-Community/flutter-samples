import 'package:flutter/foundation.dart';
import 'package:learn_bloc_pattern/data_layer/models/hit.dart';
import 'package:learn_bloc_pattern/data_layer/services/api_service.dart';

class HitRepository {
  final ApiService apiService;
  List<Hit> _currentHits = [];

  List<Hit> get currentHits => [..._currentHits];

  HitRepository({@required this.apiService});

  Future<List<Hit>> getHitsList(String query) async {
    _currentHits = await apiService.fetchHitLists(query);
    return currentHits;
  }
}
