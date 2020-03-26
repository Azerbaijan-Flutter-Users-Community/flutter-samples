import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_finder/ui/locations_screen.dart';
import '../bloc/bloc.dart';

class LocationQueryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Finder'),
      ),
      body: BlocListener<LocationBloc, LocationState>(
          listener: (context, locationState) async {
        if (locationState is LocationLoadedState) {
          await Navigator.pushNamed(context, LocationsScreen.routeName,
              arguments: locationState.locations);
        }
      }, child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                locationState is LocationLoadingState
                    ? _buildLoadingStateUi()
                    : _buildInitialStateUi(context),
                if (locationState is LocationErrorState) _buildErrorStateUi(),
              ],
            ),
          );
        },
      )),
    );
  }
}

_submitLocationQuery(BuildContext context, String query) {
  final locationBloc = BlocProvider.of<LocationBloc>(context);
  locationBloc.dispatch(GetLocationEvent(query));
}

_buildErrorStateUi() {
  return Text("Error has occured!");
}

_buildLoadingStateUi() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

_buildInitialStateUi(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'enter the location',
        border: OutlineInputBorder(),
      ),
      onSubmitted: (submittedData) {
        _submitLocationQuery(context, submittedData);
      },
    ),
  );
}
