import 'dart:convert';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});
  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var isGettingLocation = false;
  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final latitude = _pickedLocation!.latitude;
    final longitude = _pickedLocation!.latitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=12&size=400x400&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=AIzaSyAcF_B3PqbpqPunPZ4axjdIwTZOKeYD35g';
  }
  Future<void>  _saveLocation(double latitude, double longitude) async{
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAcF_B3PqbpqPunPZ4axjdIwTZOKeYD35g');
    final response = await http.get(url);
    final respData = json.decode(response.body);

    final address = respData['results'][0]['formatted_address'];
    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: latitude, longitude: longitude, address: address);
      isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);

  }
  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(
      () {
        isGettingLocation = true;
      },
    );
    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;
    if (latitude == null || longitude == null) {
      return;
    }
    _saveLocation(latitude, longitude);
  }

  void _selectLocation() async {
    LatLng? pickedLocation;
    pickedLocation = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const MapScreen(),),);
    if(pickedLocation == null){
      return;
    }
    _saveLocation(pickedLocation.latitude, pickedLocation.longitude);

  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location chosen',
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
      textAlign: TextAlign.center,
    );
    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );
    }
    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          height: 170,
          width: double.infinity,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectLocation,
              icon: const Icon(Icons.map),
              label: const Text('Select Location'),
            )
          ],
        )
      ],
    );
  }
}
