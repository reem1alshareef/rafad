import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rafad1/data/app_session.dart';
class UserService {
  static saveCurrentUser() async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "name": "",
      "email": currentUser.email,
    });
  }
}