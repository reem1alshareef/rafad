import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/pilgrim_view_booking/rate_review.dart';
import 'package:rafad1/pilgrim_view_booking/viewAccepted.dart';
import 'package:rafad1/pilgrim_view_booking/viewPending.dart';
//import 'package:rafad1/screens/CampaignViewAccepted.dart';
//import 'package:rafad1/screens/CampaignViewPending.dart';
//import 'package:rafad1/screens/CampaignViewRejected.dart';
//import 'package:rafad1/screens/adminView.dart';
import 'package:rafad1/screens/welcome_screen.dart';

class PilgrimView extends StatelessWidget {
  static const String screenRoute = 'PilgrimView';
  const PilgrimView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF455D83),
            title: const Text('My Bookings'),
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
            children: const [
              TabBar(labelColor: Colors.blueGrey, tabs: [
                Tab(
                    text: 'Pending',
                    icon: Icon(
                      Icons.assignment_outlined,
                      color: Colors.blueGrey,
                    )),
                Tab(
                    text: 'Accepted',
                    icon: Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Colors.blueGrey,
                    )),
                Tab(
                    text: 'Rate and Review',
                    icon: Icon(
                      Icons.assignment_late_outlined,
                      color: Colors.blueGrey,
                    )),
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    //First Tab
                    viewPending(),
                    viewAccepted(),
                    RateReview(),
                    // Second Tab

                    //Third Tab
                  ],
                ),
              ),
            ],
          ),
        )
        );
  }
}
