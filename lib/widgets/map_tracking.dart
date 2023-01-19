import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTracking extends StatefulWidget {
  const MapTracking({super.key});

  @override
  State<MapTracking> createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  final Completer<GoogleMapController> _conntroller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926,
      -122.03272188); //هذي الارقام هل تعتمد على الموقع اللي ابغاه ؟
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Track Campaign",
            style: TextStyle(color: Color.fromARGB(255, 5, 0, 0), fontSize: 16),
          ),
        ),
        body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: sourceLocation,
              zoom: 14.5,
            ),
            markers: {
              Marker(
                markerId: MarkerId("source"),
                position: sourceLocation,
              ),
              Marker(
                markerId: MarkerId("distnation"),
                position: sourceLocation,
              ),
            }));
  }
}
