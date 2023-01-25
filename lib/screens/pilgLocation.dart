// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';


// class pilgLocation extends StatefulWidget {
//   static const String screenRoute = 'pilgLocation.dart';
//   const pilgLocation({Key? key}) : super(key: key);
// //const CurrentLocationScreen({super.key});
//   @override
//   _pilgLocationState createState() => _pilgLocationState();
// }

// class _pilgLocationState extends State<pilgLocation> {
//   late GoogleMapController googleMapController;
//   final _firestore = FirebaseFirestore.instance;
//   static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

//   Set<Marker> markers = {};

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("select current location"),
//       //   centerTitle: true,
//       // ),
//       body: GoogleMap(
//         initialCameraPosition: initialCameraPosition,
//         markers: markers,
//         zoomControlsEnabled: false,
//         mapType: MapType.normal,
//         onMapCreated: (GoogleMapController controller) async {
//               DocumentSnapshot variable = await _firestore
//                                     .collection('AcceptedCampaigns')
//                                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                                     .get();
//                                 String pilgrimID = variable['pilgrimID'];


// DocumentSnapshot variable2 = await _firestore
//                                     .collection('AcceptedCampaigns')
//                                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                                     .collection('pilgrimEmrgency')
//                                     .doc(pilgrimID)
//                                     .get();
//                                 var latitude = variable['latitude'];
//                                 var longitude = variable['longitude'];

//             controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 14)));
// ;
//         markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(latitude, longitude)));
// setState(() {});
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
        
//         onPressed: () async {
// //           DocumentSnapshot variable = await _firestore
// //                                     .collection('AcceptedCampaigns')
// //                                     .doc(FirebaseAuth.instance.currentUser?.uid)
// //                                     .get();
// //                                 String pilgrimID = variable['pilgrimID'];


// // DocumentSnapshot variable2 = await _firestore
// //                                     .collection('AcceptedCampaigns')
// //                                     .doc(FirebaseAuth.instance.currentUser?.uid)
// //                                     .collection('pilgrimEmrgency')
// //                                     .doc(pilgrimID)
// //                                     .get();
// //                                 var latitude = variable['latitude'];
// //                                 var longitude = variable['longitude'];
                                
//           _determinePosition();

//           // googleMapController
//           //     .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 14)));


//           // //markers.clear();

//           // markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(latitude, longitude)));

//           // setState(() {});

//         },
//         label: const Text("view pilgrim Location"),
//         icon: const Icon(Icons.location_history),
//         backgroundColor:  Color.fromARGB(255, 184, 20, 20),
//       ),
//   );
//     }


//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();

//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled');
//     }

//     permission = await Geolocator.checkPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         return Future.error("Location permission denied");
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied');
//     }
// //     DocumentSnapshot variable = await _firestore
// //                                     .collection('AcceptedCampaigns')
// //                                     .doc(FirebaseAuth.instance.currentUser?.uid)
// //                                     .get();
// //                                 String pilgrimID = variable['pilgrimID'];


// // DocumentSnapshot variable2 = await _firestore
// //                                     .collection('AcceptedCampaigns')
// //                                     .doc(FirebaseAuth.instance.currentUser?.uid)
// //                                     .collection('pilgrimEmrgency')
// //                                     .doc(pilgrimID)
// //                                     .get();
// //                                 var latitude = variable['latitude'];
// //                                 var longitude = variable['longitude'];
                                
//     // googleMapController
//     //           .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 14)));


//           //markers.clear();

//           // markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(latitude, longitude)));

//               // setState(() {});
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CurrentLocationScreen extends StatefulWidget {
  static const String screenRoute = 'CurrentLocationScreen.dart';
  const CurrentLocationScreen({Key? key}) : super(key: key);
//const CurrentLocationScreen({super.key});
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {
  late GoogleMapController googleMapController;
  final _firestore = FirebaseFirestore.instance;
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("select current location"),
      //   centerTitle: true,
      // ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));


          markers.clear();

          markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));

          setState(() {});

        },
        label: const Text("send my Location"),
        icon: const Icon(Icons.location_history),
        backgroundColor:  Color.fromARGB(255, 184, 20, 20),
      ),
  );
    }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    

    return position;
  }
}
