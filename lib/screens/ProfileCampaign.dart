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



 
class ProfileCampaign extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';
  const ProfileCampaign({super.key});
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<ProfileCampaign> {
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
        in _firestore.collection('AcceptedCampaigns').snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }
Map<String, dynamic>  map ={} ;


void getData() async{
await
FirebaseFirestore.instance.collection('AcceptedCampaigns')
.doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
setState(() {
  map = value.data()! ; 

});
print(map["name"]);

print('00000000000000000000000000000000000000000000000000');
}).catchError((onError){
print(onError);
print('999999999999999999999999999999999999999999999999999');
});
}

  @override
  Widget build(BuildContext context) {
   final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('AcceptedCampaigns').snapshots();
        
//String name  = map['name'] ;

//String commercialID  = map['commercial_ID'] ;
//String email  = map['email'] ;
//String phone  = map['phoneNumber'] ;
//String address  = map['address'] ;
//String description  = map['description'] ;



     return Scaffold(
        backgroundColor: Color.fromARGB(255, 139, 177, 195),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Column(
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
              InfoCard(text: map['name'], icon: Icons.account_circle_rounded, onPressed: () async {}),
              InfoCard(text: map['commercial_ID'], icon: Icons.badge, onPressed: () async {}),
              InfoCard(text: map['phoneNumber'], icon: Icons.phone, onPressed: () async {}),
              InfoCard(text: map['email'], icon: Icons.email, onPressed: () async {}),
              InfoCard(
                  text: map['address'],
                  icon: Icons.add_location_alt_rounded,
                  onPressed: () async {}),
              InfoCard(text: map['description'], icon: Icons.app_registration_rounded, onPressed: () async {}),


              MyButton(color: const Color(0xFF455D83),
                                        title: 'Update Profile',
                                        onPressed:  () async  {}), 
              MyButton(color: const Color(0xFF455D83),
                                        title: 'Delete Account',
                                        onPressed:  () async  {DeletePilgrim();}), 
             

            ],
            
          ),
          
        ));
  }
}