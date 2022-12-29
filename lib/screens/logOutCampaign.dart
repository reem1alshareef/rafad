import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';
//import 'dart:js';

// void main(){
//   runApp(logOutAdmin());
// }
class logOutCampaign extends StatelessWidget {
  static const String screenRoute = 'logOutCampaign';
  logOutCampaign({super.key});

  void signUserOut() {
  FirebaseAuth.instance.signOut();
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: signUserOut,
              icon: Icon(Icons.logout),
            )
           // const SizedBox(height: 30),
          ],
          title: Text("campaign main home page"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover)),
        
        ));
  }
}
