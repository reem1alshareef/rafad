// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key, this.docId});
//   final String? docId;

//   // User user = FirebaseAuth.instance.currentUser!;
//   @override
//   Widget build(BuildContext context) {
//   CollectionReference users = FirebaseFirestore.instance.collection('Accespted-Bookings');
//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: users.doc(docId).get(),
//         builder: ((context, snapshot) {
//           if (snapshot.hasError) {
//             return Text("Something went wrong");
//           }
//           if (snapshot.hasData && !snapshot.data!.exists) {
//             return const Text("Document does not exist");
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//             return Text("Name: ${data['name']} HajjID: ${data['HajjID']}");
//           }
//           return const Text('Loading');
//         }),
//       )
//     );
//   }
// }

// StreamBuilder(
//         stream:  FirebaseFirestore.instance.collection('Accepted-Bookings').snapshots(),
//         builder: (context, userSnapshot) {
//         return userSnapshot.hasData ?
//          ListView.builder(
//           itemCount: userSnapshot.data?.docs.length,
//           itemBuilder: ((context, index) {
//             DocumentSnapshot usersData = userSnapshot.data!.docs[index];
//             if (usersData.data()['name'].toString().startsWith('h'))
//             // return Center(child: Text(usersData.data()['name']).toString() ?? '',)
            
//           }),
//          )
//          :
//          Container();
//       } ,),