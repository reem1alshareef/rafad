import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:rafad1/screens/LocationService.dart';
import '../widgets/my_button.dart';
import 'package:rafad1/screens/emergencyList.dart';
//import 'mapService.dart';

class ProfileCampaign extends StatefulWidget {
  static const String screenRoute = 'ProfileCampaign.dart';
  const ProfileCampaign({super.key});

  @override
  _ProfileCampaignState createState() => _ProfileCampaignState();
}

class _ProfileCampaignState extends State<ProfileCampaign> {
  final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();
  late final double _latitude;
  late final double _longitude;

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

                LocationService _LocationService = LocationService();
                _LocationService.CampsendLocationToDataBase(context);

///////////////////////////////
              },
            ),
            MyButton(
              color: Color.fromARGB(55, 4, 66, 55),
              title: 'click here to udpate your Location',
              onPressed: () async {
//////////////////////////هذا اللي يعرض الماب الحين يابتول حطيته عشان تجربين الخريطة تطلع ولا لا

                LocationService _locationService = LocationService();
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
