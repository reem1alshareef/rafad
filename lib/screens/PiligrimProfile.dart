import 'package:flutter/material.dart';
import 'package:rafad1/screens/PiligrimProfile.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // for 5 try
import 'package:location/location.dart' as loc; // for 5 try
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/Card.dart';

// our data

String  name = "meshivanshsingh.me";
String commercial_ID  = "" ;
String email = '' ;
String phone = "90441539202"; // not real number :)
String address = "Lucknow, India";
String description = "Lucknow, India";

/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:rafad1/screens/navigation_screen.dart'; الكود السابق
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:rafad1/screens/ProfileCampaign.dart';
import 'package:rafad1/screens/campaignRealMap.dart';
import 'dart:async';*/

class PiligrimProfile extends StatefulWidget {
  static const String screenRoute = 'PiligrimProfile.dart';
  const PiligrimProfile({super.key});

  @override
  _PiligrimProfileState createState() => _PiligrimProfileState();
}

void getData() async {

User? user = FirebaseAuth.instance.currentUser; 
final DocumentSnapshot userDoc = await FirebaseFirestore
.instance.collection("AcceptedCampaigns")
.doc(FirebaseAuth.instance.currentUser?.uid)
.get();


email = userDoc.get('email');

}

class _PiligrimProfileState extends State<PiligrimProfile> {
  double latController = (24.7232056); //ضبطت هذي الحركة
  double lngController = (46.636731); //ضبطت هذي الحركة

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      
        backgroundColor: Colors.blueGrey[800],
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
              Text(
                "Campaign",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "",
                ),
              ),
              Text(
                "Profile",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey[200],
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd
              InfoCard(text: name, icon: Icons.email, onPressed: () async {}),
              InfoCard(text: commercial_ID, icon: Icons.email, onPressed: () async {}),
              InfoCard(text: phone, icon: Icons.nat, onPressed: () async {}),
              InfoCard(
                  text: address,
                  icon: Icons.location_city,
                  onPressed: () async {}),
              InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
              InfoCard(text: description, icon: Icons.email, onPressed: () async {}),


            ],
          ),
        ));
  }
}