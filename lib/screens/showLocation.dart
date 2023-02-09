


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class showLocation extends StatelessWidget {
  final double latitude;
  final double longitude;

  showLocation({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location on Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15.0,
        ),
        markers: Set.of([
          Marker(
            markerId: MarkerId("marker_1"),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(
              title: 'Location',
            ),
          ),
        ]),
      ),
    );
  }
}