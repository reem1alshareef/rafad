// ignore_for_file: camel_case_types

import "package:flutter/material.dart";
import 'package:rafad1/screens/adminView.dart';
import 'package:rafad1/screens/forget_pw.dart';
import '../screens/add_description.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:rafad1/screens/logOutPilgrim.dart';

import '../screens/welcome_admin.dart';


class nav_admin extends StatefulWidget {
  const nav_admin({super.key});

  @override
  State<nav_admin> createState() => _nav_adminState();
}


class _nav_adminState extends State<nav_admin> {

int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget> [
    Center(child: Text('pilgrims', style: TextStyle(fontSize: 72),),),//DeleteCampaign(),
    Center(child: Text('announcement', style: TextStyle(fontSize: 72),),),//DeletePilgrim(),
    //View()
      ];

  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),

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
          ),
          BottomNavigationBarItem(  
            icon: Icon(Icons.request_page),  
            label:'Requests',  
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


    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///

class nav_campaign extends StatefulWidget {
  const nav_campaign({super.key});

  @override
  State<nav_campaign> createState() => _nav_campaignState();
}

class _nav_campaignState extends State<nav_campaign> {

  int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget> [
    Center(child: Text('requests', style: TextStyle(fontSize: 72),),),//request(),
    Center(child: Text('pilgrims', style: TextStyle(fontSize: 72),),),
    Center(child: Text('announcement', style: TextStyle(fontSize: 72),),),
    AddDescription(),
    logOutCampaign()
    
    
      ];

  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Home',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.search),  
            label:'Search',  
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


    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
class nav_pilgrim extends StatefulWidget {
  const nav_pilgrim({super.key});

  @override
  State<nav_pilgrim> createState() => _nav_pilgrimState();
}

class _nav_pilgrimState extends State<nav_pilgrim> {

int _selectedIndex = 0;
  
  static const List<Widget> _widgetOptions = <Widget> [
    Center(child: Text('bookings', style: TextStyle(fontSize: 72),),),
    logOutPilgrim(),
    Center(child: Text('announcement', style: TextStyle(fontSize: 72),),),
    Center(child: Text('emergency', style: TextStyle(fontSize: 72),),),
    Center(child: Text('profile', style: TextStyle(fontSize: 72),),),
  ];

  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Home',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.search),  
            label:'Search',  
            backgroundColor: Color(0xFF455D83) 
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.announcement),  
            label:'Announcement',  
            backgroundColor: Color(0xFF455D83)  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.emergency),  
            label:'Emergency',  
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


    );
  }
}