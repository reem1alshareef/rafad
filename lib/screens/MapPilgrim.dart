import 'package:flutter/material.dart';
import 'package:rafad1/screens/MapPilgrim.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // for 5 try
import 'package:location/location.dart' as loc; // for 5 try
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navigation_screen.dart';

class MapPilgrim extends StatefulWidget {
  static const String screenRoute = 'PiligrimProfile.dart';
  const MapPilgrim({super.key});

  @override
  _MapPilgrimState createState() => _MapPilgrimState();
}

//(21.3878387)(39.9144660)
class _MapPilgrimState extends State<MapPilgrim> {
  double latController = (24.7232056); //ضبطت هذي الحركة
  double lngController = (46.636731); //ضبطت هذي الحركة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: Text("Piligrim Profile"),
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // ممتاز هنا بجرب احضر اللوكيشن من الفايربيس وبيضبط ان شاء الله
          Container(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NavigationScreen(
                          latController, //double.parse(latController.text),
                          lngController))); //double.parse(lngController.text))));
                },
                child: Text('Get Camapign Directions')),
          ),
        ]),
      ),
    );
  }
}
