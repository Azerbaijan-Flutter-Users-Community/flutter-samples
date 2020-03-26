import 'package:flutter/material.dart';
import '../models/hit_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../http_exception/http_exception.dart';

class HitsProvider with ChangeNotifier {
  List<HitItem> _hits = [];

  List<HitItem> get hits {
    return [..._hits];
  }

  Future<void> getHits() async {
    const url = 'https://pixabay.com/api/?key=13419150-d3051e0affe39f143c6161926&q=books&image_type=photo';

    try {
    final response = await http.get(Uri.encodeFull(url));
    final extracteddata = json.decode(response.body);
    List<HitItem> loadedHits = [];
    final hits = extracteddata['hits'];
    hits.forEach((hit) {
      loadedHits.add(HitItem.formJson(hit));
    });
    _hits = loadedHits;
    notifyListeners();
    } catch(error){
      throw HttpException('Something went wrong!');
    }   
  }

  Future<void> getNewHints() async {
    const url = 'https://pixabay.com/api/?key=13419150-d3051e0affe39f143c6161926&q=flowers&image_type=photo';

    try {
    final response = await http.get(Uri.encodeFull(url));
    final extracteddata = json.decode(response.body);
    List<HitItem> loadedHits = [];
    final hits = extracteddata['hits'];
    hits.forEach((hit) {
      loadedHits.add(HitItem.formJson(hit));
    });
    _hits = loadedHits;
    notifyListeners();
    } catch(error){
      throw HttpException('Something went wrong!');
    }   
  }
}