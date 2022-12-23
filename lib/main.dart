import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:rafad1/screens/signUP_pilgrim.dart'; //اضفت هذي عشان اشغل الاسين اب
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/screens/signUp_campaign.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
        initialRoute: WelcomeScreen.screenRoute, //بدل الهوم
        routes: {
          WelcomeScreen.screenRoute: (context) => WelcomeScreen(),
          SignUpPilgrim.screenRoute: (context) => SignUpPilgrim(),
          SignUpCampaign.screenRoute: (context) => SignUpCampaign(),
          //LoginPage.screenRoute: (context) => LoginPage(),
        });
  }
=======
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/screens/HomePage.dart';
import 'package:rafad1/screens/shared.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
// ignore: unused_local_variable
var DefaultFirebaseOptions;
// initializing the firebase app
runApp(const GoogleSignIn()); // calling runApp
}

// google signin stateful widget
class GoogleSignIn extends StatefulWidget {
const GoogleSignIn({Key? key}) : super(key: key);
@override
_GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
var islogin;

checkUserLoginState() async {
	await Shared.getUserSharedPreferences().then((value) {
	setState(() {
		islogin = value;
	});
	});
}

@override
void initState() {
	checkUserLoginState();
	super.initState();
}

@override
Widget build(BuildContext context) {
	return MaterialApp(
	title: 'GEEKS FOR GEEKS',
	debugShowCheckedModeBanner:
		false, // debug banner false that is show on corner
	theme: ThemeData(
		primarySwatch: Colors.cyan, // color to our app
	),
	home: islogin != null
		? islogin
			: HomePage()
	);
}
>>>>>>> reemBransh
}
