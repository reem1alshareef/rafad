import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/CampaignViewAccepted.dart';
import 'package:rafad1/screens/CampaignViewPending.dart';
import 'package:rafad1/screens/CampaignViewRejected.dart';
import 'package:rafad1/screens/adminView.dart';
import 'package:rafad1/screens/welcome_screen.dart';

class CampaignView extends StatelessWidget {
  static const String screenRoute = 'CampaignView';
  const CampaignView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF455D83),
            title: Text('Pilgrims Bookings'),
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(
            //       Icons.logout,
            //       color: Colors.white,
            //     ),
            //     onPressed: () {
            //       FirebaseAuth.instance.signOut();
            //       Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            //     },
            //   )
            // ],
          ),
          body: Column(
            children: [
              TabBar(labelColor: Colors.blueGrey, tabs: [
                Tab(
                    text: 'Pending',
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.blueGrey,
                    )),
                Tab(
                    text: 'Accepted',
                    icon: Icon(
                      Icons.check_circle_outline,
                      color: Colors.blueGrey,
                    )),
                Tab(
                    text: 'Rejected',
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Colors.blueGrey,
                    )),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    //First Tab
                    ViewPending(),
                    ViewAccepted(),
                    ViewRejected(),
                    // Second Tab

                    //Third Tab
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
