import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';

// ignore: camel_case_types
class logOutPilgrim extends StatelessWidget {
  static const String screenRoute = 'logOutPilgrim';
  logOutPilgrim({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  /*void signUserOut() {
    FirebaseAuth.instance.signOut();
    //Navigator.pushNamed(context, WelcomeScreen.screenRoute);, هذي الطريقة ماضبطت حقي ان شاء الله يضبط,  بتول ضبطي النافيقيتر
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pilgrim main home page"),
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
        actions: [
          const SizedBox(height: 30),
          MyButton(
            color: Color.fromARGB(255, 250, 73, 13),
            title: 'Sign Out',
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
          ),
          /*IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )*/
        ],
      ),
      body: Center(
          child: Text(
        "hello! you have logged in As pilgrim" ,
        //+ user.email!,
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
