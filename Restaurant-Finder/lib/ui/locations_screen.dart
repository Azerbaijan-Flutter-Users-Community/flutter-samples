import 'package:flutter/material.dart';
import '../models/location.dart';

class LocationsScreen extends StatelessWidget {
  static const routeName = '/location-screen';

  @override
  Widget build(BuildContext context) {
    final locations =
        ModalRoute.of(context).settings.arguments as List<Location>;

    return Scaffold(
      appBar: AppBar(
        title: Text('Locations'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
          child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text(locations[index].cityId.toString()),
          ),
          title: Text(locations[index].title),
          subtitle: Text(locations[index].cityName),
        ),
        itemCount: locations.length,
      )),
    );
  }
}
