// ignore_for_file: camel_case_types

import "package:flutter/material.dart";
import 'package:rafad1/admin/DeletePilgrim.dart';
import 'package:rafad1/screens/CampaignView.dart';
import 'package:rafad1/screens/MapPilgrim.dart';
import 'package:rafad1/screens/PiligrimProfile.dart';
import 'package:rafad1/screens/ProfileCampaign.dart';
import 'package:rafad1/screens/ViewCampaignPlan.dart';
import 'package:rafad1/screens/MapCampaign.dart';
import 'package:rafad1/screens/adminView.dart';
import 'package:rafad1/screens/forget_pw.dart';
import 'package:rafad1/screens/listOfPilgrims.dart';
import 'package:rafad1/screens/viewProblem.dart';
import 'package:rafad1/screens/view_booking.dart';
import 'package:rafad1/search/search_campaign.dart';
import 'package:rafad1/search/search_pilgrim.dart';
import '../pilgrim_view_booking/pilgrimViewBooking.dart';
import '../screens/add_description.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:rafad1/screens/available_campaigns.dart';
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
    View(),
    ViewProblem(),
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
              backgroundColor: Color(0xFF455D83),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_remove),
                label: 'Pilgrims',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_moderator_outlined),
                label: 'Requests',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.report),
                label: 'Report',
                backgroundColor: Color(0xFF455D83)),
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
    ListOfPilgrim(),
    CampaignPlan(),
    emergencyList(),
    MapCampaign(),
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
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.people_outline),
                label: 'Pilgrims',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Plan',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety_outlined),
                label: 'Emergencies',
                backgroundColor: Color.fromARGB(255, 184, 20, 20)),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Location',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
                backgroundColor: Color(0xFF455D83)),
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
    availableCampaigns(), //SearchCampaign(),
    ViewCampaignPlan(),
    emergency(),
    MapPilgrim(),
    PiligrimProfile() ,
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
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.mosque_outlined),
                label: 'Campaigns',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Plan',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.health_and_safety_outlined),
                label: 'Emergency',
                backgroundColor: Color.fromARGB(255, 184, 20, 20)),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                label: 'Location',
                backgroundColor: Color(0xFF455D83)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
                backgroundColor: Color(0xFF455D83)),
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
