import 'package:flutter/material.dart';
//import 'package:flutter_gmaps/directions_model.dart';
//import 'package:flutter_gmaps/directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class announcementLocation extends StatefulWidget{
  //  final String title;
  //  final String description;


  //const announcementLocation({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _announcementLocation createState()=>_announcementLocation();

  // String getDescription(){
  //   return description;
  // }

  // String getTitle(){
  //   return title;
  // }

}

class _announcementLocation extends State<announcementLocation>{
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  late Marker _origin;
  late Marker _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
  List<String> location = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body : GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,)

      //Navigator.pop(context, location);
    );
  }
}