import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';
//import 'dart:js';

// void main(){
//   runApp(logOutAdmin());
// }
class logOutAdmin extends StatefulWidget {
  static const String screenRoute = 'logOutAdmin';
  logOutAdmin({super.key});

  @override
  State<logOutAdmin> createState() => _logOutAdmin();
}

class _logOutAdmin extends State<logOutAdmin> {

  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget> [
    //DeleteCampaign(),
    //DeletePilgrim(),
  ];

  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

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
          ],
        ),


         bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person_remove),  
            label: 'Campaigns',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person_remove),  
            label:'Pilgrims',  
            backgroundColor: Color(0xFF455D83) 
          )  
        ],  
        type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.white,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
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

                    _widgetOptions.elementAt(_selectedIndex),


                    MyButton(
                      color: Color.fromARGB(255, 250, 73, 13),
                      title: 'Sign Out',
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, WelcomeScreen.screenRoute);
                      },
                    ),
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
