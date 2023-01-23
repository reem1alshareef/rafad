import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:tradebook/firebaseService.dart';
//import 'package:tradebook/providerData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafad1/screens/emergency.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:developer';

class LocationService {

  final _firestore = FirebaseFirestore.instance;

  sendLocationToDataBase(context) async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

      _firestore
        .collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser?.uid).update(
      {
        'latitude': _locationData.latitude,
        'longitude': _locationData.longitude,
      },
    );
  }

  
  goToMaps(double latitude, double longitude) async {
    String mapLocationUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    final String encodedURl = Uri.encodeFull(mapLocationUrl);
    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }
}