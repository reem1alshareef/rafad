import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/forget_pw.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';

import 'add_description.dart';

class logOutCampaign extends StatefulWidget {
  static const String screenRoute = 'logOutCampaign';
  const logOutCampaign({super.key});

  @override
  State<logOutCampaign> createState() => _logOutCampaign();
}

class _logOutCampaign extends State<logOutCampaign> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
            icon: const Icon(Icons.logout), //hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
          ),
        ],
        title: Text("campaign profile"),
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assests/images/background.png"),
                fit: BoxFit.cover)),
        child: Center(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          //DeleteCampaign(),

          child: Text(
            'Your request has been sent to admin, please wait for the response',
            style: TextStyle(fontSize: 20),
          ),
        ), //DeleteCampaign(),
      ),
    );
  }
}
