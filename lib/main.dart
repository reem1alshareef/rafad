import 'package:flutter/material.dart';
import 'package:rafad1/firebase_options.dart';
import 'package:rafad1/screens/CampaignView.dart';
import 'package:rafad1/screens/Chat_screen.dart';
import 'package:rafad1/screens/adminView.dart';
import 'package:rafad1/screens/signUP_pilgrim.dart';
import 'package:rafad1/screens/welcome_admin.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/screens/signUp_campaign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafad1/screens/logOutPilgrim.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();

  //await Firebase.initializeApp();

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
      debugShowCheckedModeBanner: false,
      //home: logOutAdmin(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Chat_screen(),
      // initialRoute: WelcomeScreen.screenRoute,
      // routes: {
      //   WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
      //   SignUpPilgrim.screenRoute: (context) => const SignUpPilgrim(),
      //   SignUpCampaign.screenRoute: (context) => const SignUpCampaign(),
      //   //logOutAdmin.screenRoute: (context) => logOutAdmin(),
      //   //logOutPilgrim.screenRoute: (context) => logOutPilgrim(),
      //   //logOutCampaign.screenRoute: (context) => logOutCampaign(),
      //   LoginPage.screenRoute: (context) => const LoginPage(),}
    );
  }
}
