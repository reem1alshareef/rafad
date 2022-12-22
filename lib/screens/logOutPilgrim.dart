import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
//import 'WelcomeScreen.dart'; بتول سوي الامبورت

class logOutPilgrim extends StatelessWidget{
  static const String screenRoute = 'logOutPilgrim';
  logOutPilgrim({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  
void signUserOut() {
    FirebaseAuth.instance.signOut();
  //Navigator.pushNamed(context, WelcomeScreen.screenRoute); بتول ضبطي النافيقيتر 
  }
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(onPressed: signUserOut,
        icon: Icon(Icons.logout),
        )
      ],
      ),
      body: Center (
        child: Text(
          "you have logged in As" + user.email!,
          style: TextStyle(fontSize: 20),
        )),
    );
    
  }
}
