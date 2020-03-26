import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationEvent extends Equatable {
  LocationEvent([List props = const <dynamic>[]]) : super(props);
}

class GetLocationEvent extends LocationEvent {
  final String query;

  GetLocationEvent(this.query): super([query]);

  @override
  String toString() => "GetLocationEvent";
}
