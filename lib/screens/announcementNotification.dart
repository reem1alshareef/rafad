// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //  class announcementNotification {

// //   final _firestore = FirebaseFirestore.instance;
// //    void DataStreams() async {
// //     await for (var snapshot
// //         in _firestore.collection('AcceptedCampaigns')
// //         .snapshots()) {
// //       for (var campaign in snapshot.docs) {
// //         print(campaign.data());
// //       }
// //     }
// //   }

// //   final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance.collection('AcceptedCampaigns').snapshots();



  
// //   //extends StatefulWidget {
// // //   static const String screenRoute = 'LoginPage';
// // //   const announcementNotification({Key? key}) : super(key: key);

// // //   @override
// // //   State<announcementNotification> createState() => _announcementNotification();

// // }

// // // class _announcementNotification extends State<announcementNotification> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // TODO: implement build
// // //     throw UnimplementedError();
// // //   }

// // // }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:expansion_tile_card/expansion_tile_card.dart';
// import 'package:flutter/src/widgets/editable_text.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rafad1/screens/welcome_screen.dart';

// import '../widgets/my_button.dart';
// import 'package:http/http.dart' as http;

// //import 'package:rafad1/screens/LoginPage.dart';
// class announcementNotification extends StatefulWidget {
// //static const String screenRoute = 'logOutPilgrim.dart';
// const announcementNotification({super.key});

//   @override
//   _announcementNotification createState() => _announcementNotification();
// }

// class _announcementNotification extends State<announcementNotification> {
//   final _firestore = FirebaseFirestore.instance;
//   String? rejectionReason;
//   bool isButtonActive = true;////// حق شرط البوتون انه مايسمح للحاج يضغط اكثر من مره
//   final _controller = TextEditingController();
  
//   User? user;



//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   bool card = false;
//   bool isVisible = true;
//   bool _submitted = false;
//   String? name;

//   String? mtoken=" ";
//   late FlutterLocalNotificationsPlugin flutterPlug=FlutterLocalNotificationsPlugin();
//   void initState(){
//     super.initState();
//     requestPermision();
//     getToken();
//     initInfo();
//   }

//   Future<void> requestPermision() async {
//     FirebaseMessaging messaging =FirebaseMessaging.instance;

//     NotificationSettings settings= await messaging.requestPermission(alert: true, announcement: false, badge: true, carPlay: false, provisional: false, sound: true);
//   }

//   void getToken () async {
// await FirebaseMessaging. instance. getToken () . then (
// (token) {
// setState(() {
// mtoken = token;
// print ("My token is $mtoken");
//   });
// saveToken(token!);
//   }
// );}

// Future<void> saveToken(String token) async {
//   await FirebaseFirestore.instance.collection('AcceptedCampaigns').doc(FirebaseAuth.instance.currentUser?.uid).set({
//         'token':token,
//       }, SetOptions(merge: true));;
// }


// Future<void> sendPushMessage(String token, String body, String title) async {
//   try{
//     await http.post(
//       Uri.parse('uri')
//     )

//   }catch Exception(e){

//   }

// }

  

//   void _submit() {
//     setState(() => _submitted = true);
//     if (_errorText == null) {}
//   }

//   String? get _errorText {
//     // at any time, we can get the text from _controller.value.text
//     final text = _controller.value.text;
//     // Note: you can do your own custom validation here
//     // Move this logic this outside the widget for more testable code
//     if (text.isEmpty) {
//       return 'Can\'t be empty ';
//     }
//     if (text.length < 4) {
//       return 'Too short';
//     }
//     // return null if the text is valid
//     return null;
//   }

//   void DataStreams() async {
//     await for (var snapshot
//         in _firestore.collection('AcceptedCampaigns')
//         .snapshots()) {
//       for (var campaign in snapshot.docs) {
//         print(campaign.data());
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> dataStream =
//         FirebaseFirestore.instance.collection('AcceptedCampaigns').snapshots();
        
//     return Scaffold(

//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title: Text('available campaign to book'),
//           backgroundColor: const Color(0xFF455D83),
//           elevation: 0,
//           actions: <Widget>[
//             IconButton(
//               icon: Icon(
//                 Icons.logout,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushNamed(context, WelcomeScreen.screenRoute);
//               },
//             )
//           ],
//         ),
//         body: SingleChildScrollView(
//             child: Column(children: [
// Padding(
//   padding: const EdgeInsets.only(top: 30),
//   child:   Container(
//   //margin: EdgeInsets.all(60), 
//     color: Color.fromARGB(255, 179, 181, 183),

//   ),
// ),
//             Container(//كود الخلفيه 
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("assests/images/background.png"),
//                   fit: BoxFit.cover),),),//كود الخلفيه لين هنا بس ما اشتغلت 

//           Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
//               child: StreamBuilder<QuerySnapshot>(
//                   stream: dataStream, 
//                   builder: (BuildContext context,
//                       AsyncSnapshot<QuerySnapshot> snapshot) {
//                     if (snapshot.hasError) {
//                       // TODO : add snackbar
//                     }
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                     final List storedocs = [];
//                     snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map a = document.data() as Map<String, dynamic>;
//                       storedocs.add(a);
//                       a['UID'] = document.id;
//                     }).toList();



//                     return Column( );
//                   },
//                   ),
//                   ),
//         ],
//         ),
//         ),
      
//         );
        
//   }
// }
