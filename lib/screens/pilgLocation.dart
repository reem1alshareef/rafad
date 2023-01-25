
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class pilgLocation extends StatefulWidget {
  static const String screenRoute = 'pilgLocation.dart';
  const pilgLocation({super.key});
  @override
  _pilgLocationState createState() => _pilgLocationState();
}

class _pilgLocationState extends State<pilgLocation> {
  final Completer<GoogleMapController> _controller = Completer();
final _firestore = FirebaseFirestore.instance;

  static const CameraPosition initialPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.0);

  // static  CameraPosition targetPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 14.0, bearing: 192.0, tilt: 60);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Google Map"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
// DocumentSnapshot variable = await _firestore
//                                     .collection('AcceptedCampaigns')
//                                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                                     .get();
//                               String pilgrimID = variable['pilgrimID'];


// DocumentSnapshot variable2 = await _firestore
//                                     .collection('AcceptedCampaigns')
//                                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                                     .collection('pilgrimEmrgency')
//                                     .doc(pilgrimID)
//                                     .get();
//                                 double latitude = variable2['_latitude'];
//                                 double longitude = variable2['_longitude'];
          goToLake();
        },
        label: const Text("go to the pilgrim"),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> goToLake() async {
    final GoogleMapController controller = await _controller.future;
    DocumentSnapshot variable = await _firestore
                                    .collection('AcceptedCampaigns')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();
                              String pilgrimID = variable['pilgrimID'];


DocumentSnapshot variable2 = await _firestore
                                    .collection('AcceptedCampaigns')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection('pilgrimEmrgency')
                                    .doc(pilgrimID)
                                    .get();
                                double latitude = variable2['_latitude'];
                                double longitude = variable2['_longitude'];

    CameraPosition targetPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 14.0, bearing: 192.0, tilt: 60);

    controller.animateCamera(CameraUpdate.newCameraPosition(targetPosition));
  }
}

// DocumentSnapshot variable = await _firestore
//                                     .collection('AcceptedCampaigns')
//                                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                                     .get();
//                               String pilgrimID = variable['pilgrimID'];


// DocumentSnapshot variable2 = await _firestore
//                                     .collection('AcceptedCampaigns')
//                                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                                     .collection('pilgrimEmrgency')
//                                     .doc(pilgrimID)
//                                     .get();
//                                 double latitude = variable2['_latitude'].latitude;
//                                 double longitude = variable2['_longitude'].longitude;