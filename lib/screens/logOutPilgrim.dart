import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/my_button.dart';
//import 'dart:js';

// void main(){
//   runApp(logOutAdmin());
// }
class logOutPilgrim extends StatefulWidget {
  //static const String screenRoute = 'logOutPilgrim';
  const logOutPilgrim({super.key});

@override
  State<logOutPilgrim> createState() => _logOutPilgrim();
}

class _logOutPilgrim extends State<logOutPilgrim> {





  final user = FirebaseAuth.instance.currentUser!;
  // void signUserOut() {
  //FirebaseAuth.instance.signOut();
  //Navigator.pushNamed(context, WelcomeScreen.screenRoute);
  //}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("pilgrim main home page"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: [
            const SizedBox(height: 30),
          ],
        ),

     
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assests/images/background.png"),
                  fit: BoxFit.cover),),),//كود الخلفيه لين هنا بس ما اشتغلت 

          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: dataStream, 
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      // TODO : add snackbar
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final List storedocs = [];
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['UID'] = document.id;
                    }).toList();
                    return Column(
                        children: List.generate(
                            storedocs.length,
                            (i) => SingleChildScrollView(
                                  child: ExpansionTileCard(
                                    elevation: 2,
                                    initialPadding:
                                        EdgeInsets.only(bottom: 7, top: 7),
                                    baseColor: Colors.blueGrey[50],
                                    expandedColor: Colors.blueGrey[50],
                                    //key: cardA,
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                          "assests/images/campaignLogo.png"),
                                      backgroundColor: Color(0xFF788AA4),
                                    ),
                                    title: Text(
                                      storedocs[i]['name'],//storedocs[i]['UID']
    //                                   _firestore.collection("acceptedCampaigns")
    // .doc(storedocs[i]['UID'])
    // .collection("pilgrimsRequest").add
    //
    // .doc(pilgrim ID);
                                    ),
                                    subtitle: Text(
                                      "Click to view campaign's details",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    children: [
                                      Divider(
                                        thickness: 1.7,
                                        height: 1.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 10.0,
                                          ),
                                          child: Center(
                                            child: Column(children: [
                                              Column(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Campaign\'s email:  ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]['email'],
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(children: [
                                                    Text(
                                                      'Campaign\'s address: ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]['address'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(children: [
                                                    Text(
                                                      'Campaign\'s commercial ID:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['commercial_ID'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(children: [
                                                    Text(
                                                      'Campaign\s Phone Number:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['phoneNumber'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ]),
                                                ),

                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(children: [
                                                    Text(
                                                      'Campaign\'s Seating Capacity:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]['seatingCapacity'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ]),
                                                ),
                                              ]),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      /////////////////buton
                                      
                                      MyButton(
                                        color: const Color(0xFF455D83),
                                        title: 'book',
                                        onPressed: () async {
                                          // User? user = await FirebaseAuth.instance.currentUser;
                                          // var vari =FirebaseFirestore.instance.collection("Pilgrims-Account").doc(user!.uid).get();
                                          // Map<String,dynamic> userData = vari as Map<String,dynamic>;
                                          // setState (() {
                                          //  String name = userData['name'];
                                          //  print(name);
                                          //  //String name = userData['name']; //or name = userData['name']
                                          //   }
                                          //   );
                                        _firestore.collection("AcceptedCampaigns").doc(storedocs[i]['UID']).collection("pilgrimsRequest").add({
                                                'bookStatus': 'booked',
                                                'pilgrimID': FirebaseAuth.instance.currentUser?.uid,
                                                ///////////////////////////here
                                                // 'name': name,//userData['name'],
                                                // 'email': 'asdfghjkldfghj',
                                                // 'number': storedocs[i]['numberP'],
                                                // 'hajId': storedocs[i]['hajIdP'],
                                                // 'disease': storedocs[i]['diseaseP'],
                                                // 'pharma': storedocs[i]['pharmaP'],
                                              },
                                              );
                                          //FirebaseFirestore.instance.collection('AcceptedCampaigns').doc(storedocs[i]['UID']).update({'seatingCapacity': FieldValue.increment(-1),});
                                        _firestore.collection("Pilgrims-Account").doc(FirebaseAuth.instance.currentUser?.uid).collection("pilgrimCampaigns").add({
                                                'bookStatus': 'pending',
                                                'campaignID': storedocs[i]['UID'],
                                                ///////////////////////////here
                                                // 'name': name,//userData['name'],
                                                // 'email': 'asdfghjkldfghj',
                                                // 'number': storedocs[i]['numberP'],
                                                // 'hajId': storedocs[i]['hajIdP'],
                                                // 'disease': storedocs[i]['diseaseP'],
                                                // 'pharma': storedocs[i]['pharmaP'],
                                              },
                                              );
                                        }
                                          // var seat , quantityref;
                                          // seat = storedocs[i]['seatingCapacity'];
                                          // quantityref = _firestore.collection("seatingCapacity").seat;
                                          // quantityref.update({"quantity" : _firestore.firebase.FieldValue.decrement(1)});
                                         ////: null ,)
                                       ) ////////////////buton
                                ],
                                ),
                                ),
                                ),
                                );
                  },
                  ),
                  ),
        ],
        ),
        ),
      
        );
        
  }
}
