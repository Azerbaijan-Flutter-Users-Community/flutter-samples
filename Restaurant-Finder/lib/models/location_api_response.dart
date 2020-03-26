import 'package:equatable/equatable.dart';
import 'location.dart';

class LocationApiResponse extends Equatable {
  final String status;
  final List<Location> locations;

  LocationApiResponse({
    this.status,
    this.locations,
  });

  factory LocationApiResponse.fromJson(Map<String, dynamic> json){
    return LocationApiResponse(
      status: json['city_name'],
      locations: (json['location_suggestions'] as List<Map<String, dynamic>>).map((location){
        return Location.fromJson(location);
      }).toList(),
    );
  }
}