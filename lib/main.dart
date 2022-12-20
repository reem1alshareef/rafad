import 'package:flutter/material.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/screens/HomePage.dart';
import 'package:rafad1/screens/shared.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
// ignore: unused_local_variable
var DefaultFirebaseOptions;
var currentPlatform = DefaultFirebaseOptions.currentPlatform;
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
}
