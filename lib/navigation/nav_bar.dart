// ignore_for_file: camel_case_types

import "package:flutter/material.dart";
import 'package:rafad1/admin/DeletePilgrim.dart';
import 'package:rafad1/screens/CampaignView.dart';
import 'package:rafad1/screens/PiligrimProfile.dart';
import 'package:rafad1/screens/ViewCampaignPlan.dart';
import 'package:rafad1/screens/ProfileCampaign.dart';
import 'package:rafad1/screens/adminView.dart';
import 'package:rafad1/screens/forget_pw.dart';
import 'package:rafad1/screens/view_booking.dart';
import 'package:rafad1/search/search_campaign.dart';
import 'package:rafad1/search/search_pilgrim.dart';
import '../pilgrim_view_booking/pilgrimViewBooking.dart';
import '../screens/add_description.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:rafad1/screens/logOutPilgrim.dart';
import 'package:rafad1/admin/DeleteCampaign.dart';
import 'package:rafad1/screens/CampaignPlan.dart';
import 'package:rafad1/screens/emergency.dart';

import '../screens/emergencyList.dart';
import '../screens/welcome_admin.dart';

class nav_admin extends StatefulWidget {
  nav_admin({super.key});

  @override
  State<nav_admin> createState() => _nav_adminState();
}

class _nav_adminState extends State<nav_admin> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const DeleteCampaign(),
    const DeletePilgrim(),
    View()
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
              icon: Icon(Icons.remove_moderator_outlined),
              label: 'Campaigns',
              backgroundColor: Color.fromARGB(255, 12, 92, 119),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_remove),
                label: 'Pilgrims',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_moderator_outlined),
                label: 'Requests',
                backgroundColor:Color.fromARGB(255, 12, 92, 119)),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5),
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

  static const List<Widget> _widgetOptions = <Widget>[
    CampaignView(),
    SearchPilgrim(),
    CampaignPlan(),
    emergencyList(),
                          //AddDescription(),
    ProfileCampaign(),     
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
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Plan',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.emergency_share_sharp),
                label: 'Emergencies',
                backgroundColor: Color.fromARGB(255, 184, 20, 20)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5),
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

  static const List<Widget> _widgetOptions = <Widget>[
    PilgrimView(),
    SearchCampaign(),
    ViewCampaignPlan(),
    emergency(),
    PiligrimProfile()
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
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Plan',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
            BottomNavigationBarItem(
                icon: Icon(Icons.emergency_share_sharp),
                label: 'Emergency',
                backgroundColor: Color.fromARGB(255, 184, 20, 20)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Color.fromARGB(255, 12, 92, 119)),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
