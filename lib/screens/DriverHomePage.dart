/*import 'dart:async';
// import 'dart:html';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final Set<Polyline> _polyline = {};
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(24.726173, 46.635952), zoom: 16);

  late Position currentPosition;
  var geolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  var order;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  final user = FirebaseAuth.instance.currentUser!;

  void locatePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = position;

      LatLng latLatPosition = LatLng(position.latitude, position.longitude);

      CameraPosition cameraPosition =
          new CameraPosition(target: latLatPosition, zoom: 16);

      newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (err) {
      print(err);
    }
  }

  void startMarker() async {
    final MarkerId markerId = MarkerId("start");
    final Marker marker = Marker(
      markerId: markerId,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 3.0),
          "assests/images/pin_source.png"),
      position: LatLng(order["start"].latitude, order["start"].longitude),
      infoWindow: InfoWindow(title: "source location"),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void endMarker() async {
    final MarkerId markerId = MarkerId("end");
    final Marker marker = Marker(
      markerId: markerId,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 3.0),
          "assests/images/pin_distnation.png"),
      position: LatLng(order["end"].latitude, order["end"].longitude),
      infoWindow: InfoWindow(title: "distnatio location"),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    List<LatLng> latLen = [
      LatLng(order["start"].latitude, order["start"].longitude),
      LatLng(order["end"].latitude, order["end"].longitude),
    ];
    startMarker();
    endMarker();
    _polyline.add(Polyline(
      polylineId: PolylineId('1'),
      points: latLen,
      width: 5,
      color: Colors.purple,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      //  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      key: scaffoldkey,
      child: Stack(
        children: <Widget>[
          Container(
            child: GoogleMap(
                padding: EdgeInsets.only(bottom: 10, left: 10),
                mapType: MapType.normal,
                markers: Set<Marker>.of(markers.values),
                polylines: _polyline,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true, // جربي هذا الكود بجوال ليلى ضروري
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controllerGoogleMap.complete(controller);
                  newGoogleMapController = controller;

                  setState(() {
                    bottomPaddingOfMap = 210.0;
                  });
                  //locationPosition();
                }),
          ),
          // end switch button
        ],
      ),
      // Requested list
    );
  }
}
*/