import 'package:flutter/material.dart';
import 'package:rafad1/screens/CampaignViewAccepted.dart';
import 'package:rafad1/screens/CampaignViewPending.dart';
import 'package:rafad1/screens/CampaignViewRejected.dart';
import 'package:rafad1/screens/adminView.dart';

class CampaignView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Pilgrims Bookings'),
          ),
          body: Column(
            children: [
              TabBar(tabs: [
                Tab(
                    icon: Icon(
                  Icons.circle_notifications,
                  color: Colors.blueGrey,
                )),
                Tab(
                    icon: Icon(
                  Icons.cancel,
                  color: Colors.blueGrey,
                )),
                Tab(
                    icon: Icon(
                  Icons.check,
                  color: Colors.blueGrey,
                ))
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
