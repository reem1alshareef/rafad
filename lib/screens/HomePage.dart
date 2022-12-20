import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final FirebaseAuth auth = FirebaseAuth.instance;
//signout function
signOut() async {
	await auth.signOut();
	Navigator.pushReplacement(
		context, MaterialPageRoute(builder: (context) => HomePage()));
}

@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		centerTitle: true,
		backgroundColor: Colors.green,
		title: Text("GEEKS FOR GEEKS"),
	),
	
	// floating Action Button using for signout ,

	floatingActionButton: FloatingActionButton(
		onPressed: () {
		signOut();
		},
		child: Icon(Icons.logout_rounded),
		backgroundColor: Colors.green,
	),

	body: Center(
		child: Text("Home page"),
	),
	);
}
}

