// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// void main() {
//   runApp(MyScreen());
// }

// class MyScreen extends StatelessWidget{

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             title: Text('Save / clear')),
//         body: Padding( padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 ElevatedButton( child: Text('save') ,onPressed:(){fetchdata("commercial_ID", true);}, )
//                 ,
//                 ElevatedButton( child: Text('delet') ,onPressed:(){fetchdata("commercial_ID" , false);}, )

//               ],


//             )


//         ));
//   }
//   Future<void> fetchdata(String commercialID, bool selected )  async {

//     try {

//       var col = FirebaseFirestore.instance.collection ("campaigns");

//       await col.get () . then ((snapshot) async {
//         for (var element in snapshot.docs) {
//           if (element ['commercial_ID']== commercialID ){

//             await FirebaseFirestore.instance.collection((selected? "AcceptedCampaigns" :"RejectedCampaigns")).add({
//               'address':element ["address"],
//               'email': element ["email"] ,
//               'name': element ["name"] ,
//               'password': element ["password"] ,
//               'phoneNumber': element ["phoneNumber"] ,
//               'seatingCapacity': element ["seatingCapacity"] ,
//               'state' : [(selected?"Accepted":"Rejected")]
//             });
//           }

// // (element ['Transaction'].toString(), element ['Amount '].toString(), element[ 'Date'], element.id);

//         }


//       });

// //setState (() {});

//     } catch (e) {
//       print (e);}

//   }


//   Future Save (String address , commercialID , email , name , password , phoneNumber , seatingCapacity) async{

//     await FirebaseFirestore.instance.collection("campaigns").add({
//       'address': address,
//       'email': email,
//       'name': name,
//       'password': password,
//       'phoneNumber': phoneNumber,
//       'seatingCapacity': seatingCapacity,
//     });


//   }
// }