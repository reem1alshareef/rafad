import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';
//import 'dart:js';

// void main(){
//   runApp(logOutAdmin());
// }
class logOutAdmin extends StatelessWidget {
  static const String screenRoute = 'logOutAdmin';
  logOutAdmin({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // void signUserOut() {
    //FirebaseAuth.instance.signOut();
    //Navigator.pushNamed(context, WelcomeScreen.screenRoute);
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("admin main home page"),
        backgroundColor: const Color(0xFF455D83),
        elevation: 0,
        actions: [
          const SizedBox(height: 30),
          MyButton(
            color: Color.fromARGB(255, 250, 73, 13),
            title: 'Sign Out',
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assts/images/background.png"),
            fit: BoxFit.cover
          )
        ),
      // body: Center(
      //     child: Text(
      //   "hello ! you have logged in As admin" ,
      //   //+ user.email!,
      //   style: TextStyle(fontSize: 20),
      // )),
      ),
    );
  }
}
