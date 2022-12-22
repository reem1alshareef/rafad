
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*void main() {
  runApp(logOutPilgrim());
}*/
class logOutPilgrim extends StatelessWidget{
  static const String screenRoute = 'welcome_screen';
  logOutPilgrim({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUsrOut() {
    FirebaseAuth.instance.signOut();
    Text('erkl;');

  }
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(onPressed: signUsrOut,
        icon: Icon(Icons.logout),
        )
      ],
      ),
      body: Center (
        child: Text(
          "logged in As" + user.email!,
          style: TextStyle(fontSize: 20),
        )),
    );
  }
}