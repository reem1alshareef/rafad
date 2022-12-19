import 'package:flutter/material.dart';
import 'package:rafad1/screens/signUP_pilgrim.dart'; //اضفت هذي عشان اشغل الاسين اب
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/screens/signUp_campaign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'haj App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:const WelcomeScreen(),
        initialRoute: WelcomeScreen.screenRoute, //بدل الهوم
        routes: {
          WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
          SignUpPilgrim.screenRoute: (context) => SignUpPilgrim(),
          SignUpCampaign.screenRoute: (context) => SignUpCampaign(),
        });
  }
}
