import 'package:flutter/material.dart';
import 'package:rafad1/firebase_options.dart';
import 'package:rafad1/screens/signUP_pilgrim.dart'; //اضفت هذي عشان اشغل الاسين اب
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/screens/signUp_campaign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafad1/screens/logOutAdmin.dart';
import 'package:rafad1/screens/logOutPilgrim.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
//شادن سوي كذا لوق ان حقك هنا import

void main() async {
  //المقطع حاط هنا void
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'haj App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: WelcomeScreen.screenRoute,
        routes: {
          WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
          SignUpPilgrim.screenRoute: (context) => const SignUpPilgrim(),
          SignUpCampaign.screenRoute: (context) => const SignUpCampaign(),
          logOutAdmin.screenRoute: (context) => logOutAdmin(),
          logOutPilgrim.screenRoute: (context) => logOutPilgrim(),
          logOutCampaign.screenRoute: (context) => logOutCampaign(),
          // LoginPage.screenRoute: (context) => LoginPage(), شادن
        });
  }
}
