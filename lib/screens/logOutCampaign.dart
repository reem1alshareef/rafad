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
  logOutCampaign({super.key});

  @override
  State<logOutCampaign> createState() => _logOutCampaign();
}

class _logOutCampaign extends State<logOutCampaign> {



  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget> [
    Center(child: Text('requests', style: TextStyle(fontSize: 72),),),
    Center(child: Text('pilgrims', style: TextStyle(fontSize: 72),),),
    Center(child: Text('announcement', style: TextStyle(fontSize: 72),),),
    AddDescription(),
    Center(child: Text('profile', style: TextStyle(fontSize: 72),),),
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
          title: Text("campaign main home page"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: [
            const SizedBox(height: 30),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Requests',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.search),  
            label:'Pilgrims',  
            backgroundColor: Color(0xFF455D83) 
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.announcement),  
            label:'Announcement',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.description),  
            label:'Description',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label:'Profile',  
            backgroundColor: Color(0xFF455D83)  
          ),  
        ],  
        type: BottomNavigationBarType.shifting,  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.white,  
        iconSize: 30,  
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
