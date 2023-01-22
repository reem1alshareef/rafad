
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/emButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/emButton.dart';
import 'package:rafad1/screens/LocationService.dart';
import '../widgets/my_button.dart';





class emergency extends StatefulWidget {
  static const String screenRoute = 'emergency.dart';
  const emergency({super.key});

  @override
  _emergencyState createState() => _emergencyState();
}

class _emergencyState extends State<emergency> {
  
  final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();
  
  double _latitude = 0;
  double _longitude = 0;
  @override


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('sending emerency request'),
        backgroundColor: Color.fromARGB(255, 184, 20, 20),
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
      ),
      body:Center(
      child: Column(
          children: [

            emButton(
              color: Color.fromARGB(255, 184, 20, 20),
              title: 'click here if you want to send emerency request !!',
                onPressed: () async{
//////////////////////////الكود اللي بيرسل اللوكيشن الحالي لليوزر
                  LocationService _locationService = LocationService();
                  _locationService.sendLocationToDataBase(context);
                  _locationService.goToMaps(
                  _latitude, _longitude);
///////////////////////////////
                  DocumentSnapshot variable = await _firestore
                                    .collection('Pilgrims-Account')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();
                                String name = variable['name'];
                                String disease = variable['disease'];
                                //String hajId = variable['hajId'];
                                String pharma = variable['pharma'];
                                String campaignID = variable['campaignID'];
                                String number = variable['number'];
                  _firestore
                  .collection("AcceptedCampaigns")
                  .doc(campaignID)
                  .collection("pilgrimEmrgency")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .set( 
                  {
                  'name': name,
                  'disease': disease,
                  'pharma': pharma,
                  'number' : number,
                  //'hajId': hajId,
                  },
            );
                },
            ),
            


      ],
            ),

    ),
    );
    }//throw UnimplementedError();
}

