// import 'dart:async';
// // import 'dart:html';
// import 'dart:ui';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DriverHomePage extends StatefulWidget {
//   const DriverHomePage({super.key});

//   @override
//   State<DriverHomePage> createState() => _DriverHomePageState();
// }

// class _DriverHomePageState extends State<DriverHomePage> {

//   Completer<GoogleMapController> _controllerGoogleMap = Completer();
//   late GoogleMapController newGoogleMapController;
//   GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

//   static final CameraPosition _kGooglePlex =
//       CameraPosition(target: LatLng(24.726173, 46.635952), zoom: 16);

//   late Position currentPosition;
//   var geolocator = Geolocator();
//   double bottomPaddingOfMap = 0;

//   Future<void> _signOut() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).popUntil((route) => route.isFirst);
//   }

//   final user = FirebaseAuth.instance.currentUser!;

//   void locatePosition() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       currentPosition = position;

//       LatLng latLatPosition = LatLng(position.latitude, position.longitude);

//       CameraPosition cameraPosition =
//           new CameraPosition(target: latLatPosition, zoom: 16);

//       newGoogleMapController
//           .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//     } catch (err) {
//       print(err);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       key: scaffoldkey,
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//               padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
//               mapType: MapType.normal,
//               myLocationButtonEnabled: true,
//               initialCameraPosition: _kGooglePlex,
//               myLocationEnabled: true,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: true,
//               onMapCreated: (GoogleMapController controller) {
//                 _controllerGoogleMap.complete(controller);
//                 newGoogleMapController = controller;

//                 setState(() {
//                   bottomPaddingOfMap = 210.0;
//                 });

//               }),
//  // end switch button
//         ],
//       ),
//       // Requested list
//     );
//   }
// }
