import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view_rate_review/campaign_view_rate.dart';
import '../widgets/my_button.dart';

class PProfile extends StatefulWidget {
  const PProfile({super.key});

  @override
  State<PProfile> createState() => _PProfileState();
}

class _PProfileState extends State<PProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child:
      MyButton(color: const Color(0xFF455D83), title: 'View Rate', onPressed: ()async {

                DocumentSnapshot variable = await FirebaseFirestore.instance
                                    .collection('AcceptedCampaigns')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();

                                    String thisCampaignId = variable['UID'];
                                    double thisAvrgRating = double.parse(variable['avrgRating']);
                                    double thisNumberOfPeople = double.parse(variable['numberOfPeople']);
                // ignore: use_build_context_synchronously
                Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  ratingsList( campaignId: thisCampaignId, averageShopRating: thisAvrgRating,  numberOfRatings: thisNumberOfPeople )));
              ;}
              ),

      )
    );
  }
}