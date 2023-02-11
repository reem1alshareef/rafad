import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // for 5 try
import 'package:rafad1/screens/edit_PiligrimProfile.dart';
import 'package:rafad1/screens/edit_ProfileCampaign.dart';
// for 5 try
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/editable_text.dart';

import '../widgets/my_button.dart';
import 'package:rafad1/screens/Card.dart';

import 'Chat_screen.dart';

// our data

String name = 'naaamee';
String hajId = "";
String email = 'TextEditingController()';
String number = 'TextEditingController()'; // not real number :)
String address = 'TextEditingController()';
String description = 'TextEditingController()';

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
  final DocumentSnapshot userDoc = await FirebaseFirestore.instance
      .collection("Pilgrims-Account")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();

  email = userDoc.get('email');
}

class _PiligrimProfileState extends State<PiligrimProfile> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;

  final _controller = TextEditingController();

  @override
  void initState() {
    getData();

    super.initState();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool card = false;
  bool isVisible = true;
  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    if (_errorText == null) {}
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty ';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  //data streeeeeeeeeeeeeemmmms

  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('Pilgrims-Account').snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  Map<String, dynamic> map = {};

  void getData() async {
    await FirebaseFirestore.instance
        .collection('Pilgrims-Account')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        map = value.data()!;
      });
      print(map["name"]);

      print('00000000000000000000000000000000000000000000000000');
    }).catchError((onError) {
      print(onError);
      print('999999999999999999999999999999999999999999999999999');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('Pilgrims-Account').snapshots();

//String name  = map['name'] ;

//String commercialID  = map['commercial_ID'] ;
//String email  = map['email'] ;
//String phone  = map['phoneNumber'] ;
//String address  = map['address'] ;
//String description  = map['description'] ;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF455D83),
          tooltip: 'Chat',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chat_screen()),
            );
          },
          child: Image.asset('assests/images/chat.png', height: 35),
        ),

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profile View'),
          backgroundColor:const Color(0xFF455D83),
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
            )
          ],
        ),
        backgroundColor: Color.fromARGB(255, 202, 217, 238),
        body: SingleChildScrollView(
          // const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              
              Text(
                "Piligrim",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "",
                ),
              ),
              Text(
                "Profile",
                style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 139, 149, 153),
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Source Sans Pro"),
              ),
              SizedBox(
                height: 10,
                width: 150,
                child: Divider(
                  color: Colors.white,
                ),
              ),

              // we will be creating a new widget name info carrd
              InfoCard(
                  text: map['name'],
                  icon: Icons.account_circle_rounded,
                  onPressed: () async {}),
              InfoCard(
                  text: map['hajId'],
                  icon: Icons.badge,
                  onPressed: () async {}),
              InfoCard(
                  text: map['number'],
                  icon: Icons.phone,
                  onPressed: () async {}),
              InfoCard(
                  text: map['email'],
                  icon: Icons.email,
                  onPressed: () async {}),
              InfoCard(
                  text: map['disease'],
                  icon: Icons.add_location_alt_rounded,
                  onPressed: () async {}),
              InfoCard(
                  text: map['pharma'],
                  icon: Icons.app_registration_rounded,
                  onPressed: () async {}),

              MyButton(
                  color: const Color(0xFF455D83),
                  title: 'Update Profile',
                  onPressed: () async {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (builder) {
                      return const edit_Pilgrim();
                    }));
                  }),
              // ignore: prefer_const_constructors
              MyButton(
                  color:  Colors.red,
                  title: 'Delete Account',
                  onPressed: () async {
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: const [
                                  Text('Delete '),
                                  Text(' account'),
                                ],
                              ),
                              content: Text(
                                  'This action cannot be undone, Are you sure you want to delete the account?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    //firebase
                                    try {
                                      setState(() async {
                                        DocumentSnapshot docCustomer =
                                            await FirebaseFirestore.instance
                                                .collection('Pilgrims-Account')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .get();

                                        String email = docCustomer['email'];
                                        String password =
                                            docCustomer['password'];

                                        //FirebaseAuth.instance.currentUser
                                          //  ?.delete();

                                        User? user = await FirebaseAuth
                                            .instance.currentUser;

                                        UserCredential authResult = await user!
                                            .reauthenticateWithCredential(
                                          EmailAuthProvider.credential(
                                            email: email,
                                            password: password,
                                          ),
                                        );

                                        authResult.user!.delete();

                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WelcomeScreen()));
                                      });
                                      //Navigator.pop(context, 'Delete');

                                    } catch (e) {
                                      //e.hashCode;
                                      //print(e.runtimeType);

                                    }
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          });
                    
                    child: Row(
                      children: const <Widget>[
                        Icon(Icons.cancel_rounded, color: Colors.redAccent),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text(' Delete account'),
                      ],
                    );
  };}),
                ],
              ),
        )
        );
          
  }
           
}