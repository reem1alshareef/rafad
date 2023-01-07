import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/logOutCampaign.dart';

//import 'package:rafad1/screens/LoginPage.dart';
class ViewRejected extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';

  @override
  _ViewRejectedState createState() => _ViewRejectedState();
}

class _ViewRejectedState extends State<ViewRejected> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('AcceptedCampaigns').doc(FirebaseAuth.instance.currentUser!.uid).collection('RejectedPilgrims').snapshots();

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                  a['id'] = document.id;
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
                                  child: Image.asset("assests/images/hajj.png"),
                                  backgroundColor: Color(0xFF788AA4),
                                ),
                                title: Text(
                                  storedocs[i]['name'],
                                ),
                                subtitle: Text(
                                  "Rejected Pilgrim",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.redAccent),
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
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           bottom: 10),
                                            //   child: Column(
                                            //     children: [
                                            //       Text(
                                            //         'Campaign\'s email:  ',
                                            //         style: TextStyle(
                                            //             color: Color(
                                            //                 0xFF455D83),
                                            //             fontWeight:
                                            //                 FontWeight
                                            //                     .w500),
                                            //       ),
                                            //       Text(
                                            //         storedocs[i]['emailP'],
                                            //         style: TextStyle(
                                            //             fontSize: 12),
                                            //         textAlign:
                                            //             TextAlign.center,
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           bottom: 10),
                                            //   child: Column(children: [
                                            //     Text(
                                            //       'Campaign\'s address: ',
                                            //       style: TextStyle(
                                            //           color:
                                            //               Color(0xFF455D83),
                                            //           fontWeight:
                                            //               FontWeight.w500),
                                            //     ),
                                            //     Text(
                                            //       storedocs[i]['address'],
                                            //       style: TextStyle(
                                            //           fontSize: 12),
                                            //     ),
                                            //   ]),
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s booking status:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['bookStatus'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ]),
                                            ),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           bottom: 10),
                                            //   child: Column(children: [
                                            //     Text(
                                            //       'Campaign\s Phone Number:  ',
                                            //       style: TextStyle(
                                            //           color:
                                            //               Color(0xFF455D83),
                                            //           fontWeight:
                                            //               FontWeight.w500),
                                            //     ),
                                            //     Text(
                                            //       storedocs[i]
                                            //           ['phoneNumberP'],
                                            //       style: TextStyle(
                                            //           fontSize: 12),
                                            //     ),
                                            //   ]),
                                            // ),
                                            /* Padding(
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
                                                      storedocs[i]['capacity'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ]),
                                                ),*/
                                          ]),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )));
              }))
    ])));
  }
}
