import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/forget_pw.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';

import 'add_description.dart';
//import 'dart:js';

// void main(){
//   runApp(logOutAdmin());
// }
class logOutCampaign extends StatefulWidget {
static const String screenRoute = 'logOutCampaign';
const logOutCampaign({super.key});

  @override
  State<logOutCampaign> createState() => _logOutCampaign();
}

class _logOutCampaign extends State<logOutCampaign> {



  
  
  final user = FirebaseAuth.instance.currentUser!;
  // void signUserOut() {
  //FirebaseAuth.instance.signOut();
  //Navigator.pushNamed(context, WelcomeScreen.screenRoute);
  //}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed:() {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                      }, icon: const Icon(Icons.logout),//hhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
                      ), 
                      ],
          title: Text("campaign main home page"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),
        
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [                   
                  MyButton(
                      color: Color.fromARGB(255, 250, 73, 13),
                      title: 'Sign Out',
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                      },
                    ),
 /*MyButton(
                      color: Color.fromARGB(255, 250, 73, 13),
                      title: 'add ',
                      onPressed: () {
                        Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddDescription()));
                      },
                    ),*/

                    // const Text(
                    //   "hello ! you have logged in successfully",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     fontWeight: FontWeight.w900,
                    //     color: Color(0xFF788AA4),
                    //   ),
                    // ),
                  ],
                ),
                // body: Center(
                //     child: Text(
                //   "hello ! you have logged in As admin" ,
                //   //+ user.email!,
                //   style: TextStyle(fontSize: 20),
                // )),
              ]),
        ));
  }
}
