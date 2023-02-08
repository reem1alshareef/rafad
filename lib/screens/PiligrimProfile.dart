import 'package:flutter/material.dart';
import 'package:rafad1/screens/PiligrimProfile.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // for 5 try
import 'package:location/location.dart' as loc; // for 5 try
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navigation_screen.dart';

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
//(21.3878387)(39.9144660)
class _PiligrimProfileState extends State<PiligrimProfile> {
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
        backgroundColor:  Color.fromARGB(255, 12, 92, 119),
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
          ButtonBar(
                  alignment:
                      MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)),)),
                      onPressed: () {
                        showDialog(
                             context: context,
                            builder:
                                (BuildContext context) {
                              return AlertDialog(
                          title: Row(
                            children:  const [
                              Text('Delete '),
                              Text(' account'),
                            ],
                          ),
                          content: 
                            
                              Text('This action cannot be undone, Are you sure you want to delete the account?'),
                            
                          
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                    backgroundColor: Colors.red,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.white , fontSize: 20),),
                            ),
                            TextButton(
                              onPressed: () async {
                                
                                //firebase
                                try{
                                  setState(
                                            () async {
                                              DocumentSnapshot docCustomer = await FirebaseFirestore.instance
                              .collection('Pilgrims-Account')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get();

                             String email = docCustomer['email'];
                             String password = docCustomer['password'];
                             
                

                          FirebaseAuth.instance.currentUser?.delete();

                                              User? user = await FirebaseAuth.instance.currentUser;
                                              
                                              UserCredential authResult= await user!.reauthenticateWithCredential(
                                                EmailAuthProvider.credential(
                                                email: email,
                                                password: password,
                                              ),);

                                              authResult.user!.delete();

                                            // ignore: use_build_context_synchronously
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const WelcomeScreen()));


                                        });
                                  //Navigator.pop(context, 'Delete');
                                  
                                } catch(e){
                                  //e.hashCode;
                                  //print(e.runtimeType);

                                }

                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                        }
                        );
                        
                      },



                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.cancel_rounded, color: Colors.redAccent),
                          Padding(padding: EdgeInsets.symmetric(vertical: 2.0),),
                          Text(' Delete account'),
                        ],
                      ),



                    ),
                  ],
                ),
        ]),
      ),
    );
  }
}