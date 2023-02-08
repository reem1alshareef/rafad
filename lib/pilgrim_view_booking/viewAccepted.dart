import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../screens/Chat_screen.dart';
import '../widgets/my_button.dart';

class viewAccepted extends StatefulWidget {
  const viewAccepted({super.key});

  @override
  State<viewAccepted> createState() => _viewAcceptedState();
}

class _viewAcceptedState extends State<viewAccepted> {
  double rating = 0;
  String? review;
  final _review = GlobalKey<FormState>();

  Future review_rate() async {
    if (_review.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );

      await FirebaseFirestore.instance
          .collection("Rate")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'rating': rating,
        'review': review,
        'campaignId': 'k',
        'UID': FirebaseAuth.instance.currentUser!.uid,
      });

      /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => ViewDescription()));*/

    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Pilgrims-Account")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("pilgrimCampaigns")
        .where('bookStatus', isEqualTo: 'Accepted')
        .snapshots();

    return Scaffold(
       floatingActionButton:  FloatingActionButton (
  backgroundColor:  Color.fromARGB(255, 12, 92, 119),
  tooltip: 'Chat',
  onPressed: () { Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Chat_screen()),);},
  child: Image.asset('assests/images/chat.png', height: 35),
),
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
                                  child:
                                      Image.asset("assests/images/kaaba.png"),
                                  backgroundColor: Color(0xFF788AA4),
                                ),
                                title: Text(
                                  storedocs[i]['name'],
                                ),
                                subtitle: Text(
                                  "Click to confirm your booking for this campaign",
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                const Text(
                                                  'This Campaign has accepted your booking request',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'Click confirm if you want to join this campaign',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 109, 94, 19),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                MyButton(
                                                    color:
                                                        const Color(0xFF455D83),
                                                    title: 'Confirm',
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'Pilgrims-Account')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid)
                                                          .set(
                                                              {
                                                            'ChosenCampaignName':
                                                                storedocs[i]
                                                                    ['name'],
                                                            'ChosenCampaignID':
                                                                storedocs[i][
                                                                    'campaignID']
                                                          },
                                                              SetOptions(
                                                                  merge: true));

                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                  "Confirm Booking"),
                                                              content: Text(
                                                                  "Are you sure you want to confirm This Campaign's Booking?"),
                                                              actions: [
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(
                                                                                30.0)),
                                                                        backgroundColor:
                                                                            Color(
                                                                                0xFF455D83)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child: const Text(
                                                                        "Cancel")),
                                                                ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(
                                                                              30.0)),
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFF455D83)),
                                                                  onPressed:
                                                                      () async {
                                                                          
                                                                    DocumentSnapshot variable = await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Pilgrims-Account')
                                                                        .doc(FirebaseAuth
                                                                            .instance
                                                                            .currentUser
                                                                            ?.uid)
                                                                        .get();
                                                                    String
                                                                        name =
                                                                        variable[
                                                                            'ChosenCampaignName'];
                                                                     Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              title: Text(
                                                                                'Success',
                                                                              ),
                                                                              content:Text('You have confirmed your booking with $name Campaign'),
                                                              );
                                                                          });
                                                                   
                                                                  
                                                                    setState(
                                                                        () async {
                                                                         
                                                                      DocumentSnapshot variable = await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Pilgrims-Account')
                                                                          .doc(FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              ?.uid)
                                                                          .get();
                                                                      String
                                                                          ID =
                                                                          variable[
                                                                              'ChosenCampaignID'];
                                                                      await FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "Pilgrims-Account")
                                                                          .doc(FirebaseAuth
                                                                              .instance
                                                                              .currentUser
                                                                              ?.uid)
                                                                          .collection(
                                                                              "pilgrimCampaigns")
                                                                          .doc(
                                                                              ID)
                                                                          .update({
                                                                        'bookStatus':
                                                                            'Confirmed'
                                                                      });

                                                                      
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                      'Confrim'),
                                                                )
                                                              ],
                                                            );
                                                          });
                                                    })
                                              ]),
                                            ),
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
