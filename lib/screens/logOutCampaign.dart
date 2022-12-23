import 'dart:js';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';

// ignore: camel_case_types
class logOutCampaign extends StatelessWidget {
  static const String screenRoute = 'logOutCampaign';
  logOutCampaign({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  /*void signUserOut() {
    FirebaseAuth.instance.signOut();
    // Navigator.pushNamed(context, WelcomeScreen.screenRoute);
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(height: 30),
          MyButton(
            color: const Color(0xFF455D83),
            title: 'Sign Out ',
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
          ),
          /*  IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )*/
        ],
      ),
      body: Center(
          child: Text(
        "you have logged in As" + user.email!,
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
