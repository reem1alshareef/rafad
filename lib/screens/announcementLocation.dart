import 'package:flutter/material.dart';
//import 'package:flutter_gmaps/directions_model.dart';
//import 'package:flutter_gmaps/directions_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
    target: LatLng(24.8343297, 46.7060573),
    zoom: 11.5,
  );

  late GoogleMapController _googleMapController;
  late Marker _origin=Marker(
          markerId: const MarkerId('origin'), 
          infoWindow: const InfoWindow(title: 'Location'), 
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(24.8343297, 46.7060573),
    draggable: true
        );//=Marker(markerId: showLoca, );
  late Marker _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  //late Location location;//=Location(24,55);
  //List<double> location = [];
  late LatLng lat= LatLng(1, 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions:<Widget> [IconButton(icon: Icon(Icons.done_rounded), onPressed: () {
        //lat=LatLng(_origin.la, longitude);
        Navigator.pop(context, lat);
       },)]),


      body : GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: ((controller) => _googleMapController=controller),

        markers: {
          /*Marker(
          onTap: () {
            print('Tapped');
          },
          draggable: true,
          markerId: MarkerId('Marker'),
          position: LatLng(24.8343297, 46.7060573),
          onDragEnd: ((newPosition) {
            lat= LatLng(newPosition.latitude, newPosition.longitude);
            //location[0]=newPosition.latitude;
            //location[1]=newPosition.longitude;
          }))*/
          if(_origin!=null)
          _origin
        },
        
        //onLongPress: _addMarker,
        onLongPress: _addMarker,
        ),


      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   foregroundColor: Colors.black,
      //   onPressed: ()=> _googleMapController.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition)),
      // ),

      

      //Navigator.pop(context, location);
    );
  }

  void _addMarker(LatLng pos){
    //if(_origin==null){
      setState(() {
        _origin=Marker(
          markerId: const MarkerId('origin'), 
          infoWindow: const InfoWindow(title: 'Location'), 
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos
        );
        lat=LatLng(pos.latitude, pos.longitude);
      });
    //}

    

  }
}