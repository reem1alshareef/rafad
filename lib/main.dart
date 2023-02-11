import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/firebase_options.dart';
import 'package:rafad1/screens/CampaignView.dart';

import 'package:rafad1/screens/CurrentLocationScreen.dart';
import 'package:rafad1/screens/MapCampaign.dart';
import 'package:rafad1/screens/Report.dart';
import 'package:rafad1/screens/adminView.dart';

import 'package:rafad1/screens/notification_accept.dart';
import 'package:rafad1/screens/signUP_pilgrim.dart';
import 'package:rafad1/screens/viewProblem.dart';
import 'package:rafad1/screens/welcome_admin.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/screens/signUp_campaign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafad1/screens/available_campaigns.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/widgets/map_tracking.dart';
import '../firebase_options.dart';
//import 'package:rafad1/screens/newAcc.dart';

// ...
/*هذي حطيتها من المقطع الاول ممكن تكون حقت الاشعار اللي من الفايربيس
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// On click listner
}
*/
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp(); // مكرر 3 مرات ليه ؟؟
  /*هذي حطيتها من المقطع الاول ممكن تكون حقت الاشعار اللي من الفايربيس
  LocalNotificationService.initialize(); //هذا حق الوكال
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);*/
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
        home: Report(),
        theme: ThemeData(
          primaryColor: Colors
              .white, // change it from swatch to colort and from wight to blue , for map
        ),
        // initialRoute: WelcomeScreen.screenRoute,
        routes: {
          WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
          SignUpPilgrim.screenRoute: (context) => const SignUpPilgrim(),
          SignUpCampaign.screenRoute: (context) => const SignUpCampaign(),
          //logOutAdmin.screenRoute: (context) => logOutAdmin(),
          //logOutPilgrim.screenRoute: (context) => logOutPilgrim(),
          //logOutCampaign.screenRoute: (context) => logOutCampaign(),
          LoginPage.screenRoute: (context) => const LoginPage(),
        });
  }
}
