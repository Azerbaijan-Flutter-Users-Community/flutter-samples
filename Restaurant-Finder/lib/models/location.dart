import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int cityId;
  final String cityName;
  final String title;

  Location({
    this.cityId,
    this.title,
    this.cityName,
  }): super([cityId, title, cityName]);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
    cityId: json['city_id'],
    title: json['title'],
    cityName: json['city_name'],
    );
  }
}