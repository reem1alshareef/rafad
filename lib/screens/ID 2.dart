import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ID extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';
  const ID({super.key});
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<ID> {
  @override
  Widget build(BuildContext context)  {
     methodID() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('Pilgrims-Account')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    String? IDs = variable['ChosenCampaignID'];

    Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("AcceptedCampaigns")
        .doc(IDs)
        .collection("Activities")
        .snapshots();
    }
    return Scaffold();
    
  }
}
