import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppSession {}

get currentUser {
  return FirebaseAuth.instance.currentUser;
}

DocumentReference get userCollection {
  return FirebaseFirestore.instance.collection("AcceptedCampaigns").doc(currentUser.uid);
}