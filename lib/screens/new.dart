//هذي اول بيج تطلع للحاج اذا سوا لوق ان
/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/DeletePilgrim.dart';
import 'package:rafad1/screens/welcome_screen.dart';

import '../widgets/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/DeletePilgrim.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/screens/Card.dart';

import '../widgets/my_button.dart';
//import 'package:rafad1/screens/LoginPage.dart';
class logOutPilgrim extends StatefulWidget {
//static const String screenRoute = 'logOutPilgrim.dart';
const logOutPilgrim({super.key});

  @override
  _logOutPilgrimState createState() => _logOutPilgrimState();
}
String commercial_ID  = "here Id" ;
String email = '' ;
String phone = "here PNumber "; // not real number :)
String address = "here adrees";
String description = "here description "; 
class _logOutPilgrimState extends State<logOutPilgrim> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;
  bool isButtonActive = true;////// حق شرط البوتون انه مايسمح للحاج يضغط اكثر من مره
  final _controller = TextEditingController();
  
  User? user;



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool card = false;
  bool isVisible = true;
  bool _submitted = false;
  String? name;

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

  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('AcceptedCampaigns')
        .snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('AcceptedCampaigns').snapshots();
        
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('available campaign to book'),
          backgroundColor: const Color(0xFF455D83),
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
        body: SingleChildScrollView(
            child: Column(children: [
Padding(
  padding: const EdgeInsets.only(top: 30),
  child:   Container(
  //margin: EdgeInsets.all(60), 
    color: Color.fromARGB(255, 179, 181, 183),

  ),
),
            Container(//كود الخلفيه 
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover),),),//كود الخلفيه لين هنا بس ما اشتغلت 

          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: dataStream, 
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      // TODO : add snackbar
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['UID'] = document.id;
                    }).toList();
                    return Column(
            children: <Widget>[
            
              Text(
                "Campaign",
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
                    color: Colors.blueGrey[200],
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
              InfoCard(text: storedocs[1]['name'], icon: Icons.account_circle_rounded, onPressed: () async {}),
              InfoCard(text: commercial_ID, icon: Icons.badge, onPressed: () async {}),
              InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
              InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
              InfoCard(
                  text: address,
                  icon: Icons.add_location_alt_rounded,
                  onPressed: () async {}),
              InfoCard(text: description, icon: Icons.app_registration_rounded, onPressed: () async {}),


              MyButton(color: const Color(0xFF455D83),
                                        title: 'Update Profile',
                                        onPressed:  () async  {}), 
              MyButton(color: const Color(0xFF455D83),
                                        title: 'Delete Account',
                                        onPressed:  () async  {DeletePilgrim();}), 
             

            ]);
                  },
                  ),
                  ),
        ],
        ),
        ),
      
        );
        
  }
}      
*/