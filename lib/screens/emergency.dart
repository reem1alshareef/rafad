
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rafad1/screens/welcome_screen.dart';
//import 'package:rafad1/services/firebase_helper.dart';
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
import 'package:rafad1/screens/CurrentLocationScreen.dart';


import 'package:rafad1/screens/emergencyList.dart';

import 'CurrentLocationScreen.dart';

class emergency extends StatefulWidget {
  static const String screenRoute = 'emergency.dart';
  const emergency({super.key});

  @override
  _emergencyState createState() => _emergencyState();
  
}

class _emergencyState extends State<emergency> {
  
  final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();
  

  @override 


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
            
            onPressed: (){

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
            
SizedBox(///////////////بس عشان يحط مسافه
      height: 50, 
    ),



            emButton(
              color: const Color.fromARGB(255, 184, 20, 20),
              title: 'click here to send emerency request !!',
                onPressed: () async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const CurrentLocationScreen();
              }));

//////////////////////////الكود اللي بيرسل اللوكيشن الحالي لليوزر

                  LocationService locationService = LocationService();
                  locationService.PilgsendLocationToDataBase(context);

///////////////////////////////
                  DocumentSnapshot variable = await _firestore
                                    .collection('Pilgrims-Account')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();
                                String name = variable['name'];
                                String disease = variable['disease'];
                                //String hajId = variable['hajId'];
                                String pharma = variable['pharma'];
                                String ChosenCampaignID = variable['ChosenCampaignID'];
                                String number = variable['number'];
                                double _latitude1 = variable['latitude'];
                                double _longitude1 = variable['longitude'];
_firestore
                  .collection("AcceptedCampaigns")
                  .doc(ChosenCampaignID)
                  .update( 
                  {
                  //'GeoPoint': GeoPoint(position.latitude, position.latitude),
                  'pilgrimID': FirebaseAuth.instance.currentUser?.uid,
                  //'hajId': hajId,
                  },);
  // getActivityProfile() async{
//   await _firestore
//   .collection('Pilgrims-Account')
//   .doc(FirebaseAuth.instance.currentUser?.uid).get().then(
//     (doc)=>{
//       setState((){
//         if (doc.data() != null){
//           _latitude = doc.data()!['latitude']??=0;
//           _longitude = doc.data()!['longitude']??=0;
//         }
//       },
      
//       ),
// },
//     );
  //     };

      //_locationService.goToMaps(_latitude, _longitude);

      // _firestore
      //             .collection("Pilgrims-Account")
      //             .doc(FirebaseAuth.instance.currentUser?.uid)
                  
      //             .update( 
      //             {
      //             'GeoPoint': GeoPoint(position.latitude, position.latitude),
      //             },);
//Position position = await Geolocator.getCurrentPosition();
                  _firestore
                  .collection("AcceptedCampaigns")
                  .doc(ChosenCampaignID)
                  .collection("pilgrimEmrgency")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .set( 
                  {
                  //'GeoPoint': GeoPoint(position.latitude, position.latitude),
                  '_latitude': _latitude1,
                  '_longitude':_longitude1,
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
