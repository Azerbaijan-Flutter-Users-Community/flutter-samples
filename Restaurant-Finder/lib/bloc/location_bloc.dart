import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../client/http_client.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  @override
  LocationState get initialState => InitialLocationState();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is GetLocationEvent) {
      yield LocationLoadingState();

      try {
        final suggestedLocations = await HttpClient().getLocations(event.query);
         yield LocationLoadedState(locations: suggestedLocations);
      } catch (error) {
        yield LocationErrorState();
        print(error); 
      }
    }
  }
}
