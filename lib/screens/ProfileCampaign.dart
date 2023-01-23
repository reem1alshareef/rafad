import 'package:flutter/material.dart';
import 'package:rafad1/screens/forget_pw.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';

import 'add_description.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';

import 'package:rafad1/screens/mapService.dart';
import '../widgets/my_button.dart';

class ProfileCampaign extends StatefulWidget {
  static const String screenRoute = 'logOutCampaign';
  const ProfileCampaign({super.key});

  @override
  State<ProfileCampaign> createState() => _logOutCampaign();
}

class _logOutCampaign extends State<ProfileCampaign> {
  final user = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();

  double _latitude = 0;
  double _longitude = 0;

/*
class Location extends StatefulWidget {
  static const String screenRoute = 'Location.dart';
  const Location({super.key});

  @override
  _emergencyState createState() => _emergencyState();
}

class _emergencyState extends State<Location> {
  
  final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();
  
  double _latitude = 0;
  double _longitude = 0;
  
  @override 
  void initState(){
    _emergencyState();
    print(FirebaseAuth.instance.currentUser?.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Update campaign location'),
        backgroundColor:  Color.fromARGB(255, 6, 78, 246),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
          ),

Container(
              //كود الخلفيه
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assests/images/background.png"),
                    fit: BoxFit.cover),
              ),
            ), // كود الخلفيه لين هنا 

        ],
      */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
            icon: const Icon(Icons.logout), //hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
          ),
        ],
        title: Text("campaign profile"),
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            MyButton(
              color: Color.fromARGB(55, 4, 66, 55),
              title: 'click here to udpate your Location',
              onPressed: () async {
//////////////////////////الكود اللي بيرسل اللوكيشن الحالي لليوزر

                mapService _locationService = mapService();
                _locationService.sendLocationToDataBase(context);

///////////////////////////////
              },
            ),
            MyButton(
              color: Color.fromARGB(55, 4, 66, 55),
              title: 'click here to see Location',
              onPressed: () async {
                mapService _locationService = mapService();
                _locationService.goToMaps(24.7231819, 46.6367413);

///////////////////////////////
              },
            ),
          ],
        ),
      ),
    );
  } //throw UnimplementedError();
}
