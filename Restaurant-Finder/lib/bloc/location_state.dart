import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/location.dart';

@immutable
abstract class LocationState extends Equatable {
  LocationState([List props = const <dynamic>[]]) : super(props);
}

class InitialLocationState extends LocationState {
   @override
  String toString() => "InitialLocationState";
}

class LocationLoadingState extends LocationState {
  @override
  String toString() => "LocationLoadingState";
}

class LocationLoadedState extends LocationState {
  final  List<Location> locations;

  LocationLoadedState({@required this.locations}): super([locations]);

  @override
  String toString() => "LocationLoadedState";
}

class LocationErrorState extends LocationState {}
