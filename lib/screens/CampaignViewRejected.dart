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
        FirebaseFirestore.instance.collection('Bookings').snapshots();

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
                                  "Click to view pilgrim's details",
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
                                                  'Pilgrim\'s Hajj ID:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['id'],
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
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: 52.0,
                                    buttonMinWidth: 90.0,
                                    children: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.0)),
                                        )),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Accept Request"),
                                                  content: const Text(
                                                      "Are you sure you want to accept pilgrim's request?"),
                                                  actions: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0)),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF455D83)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text(
                                                            "Cancel")),
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0)),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF455D83)),
                                                        onPressed: () {
                                                          // This whole code will be when campaign presses Accept
                                                          // Albatouls Notification

                                                          Navigator.of(context)
                                                              .pop();

                                                          setState(() async {
// This part will make a new collection for accepted pilgrims for this specific campaign who accepted the pilgrim?????
                                                            _firestore
                                                                .collection(
                                                                    'AcceptedBookings') // for this specific campaign
                                                                .add({
                                                              'status':
                                                                  'accepted',
                                                              'name':
                                                                  storedocs[i]
                                                                      ['name'],
                                                              // 'email':
                                                              //     storedocs[
                                                              //             i]
                                                              //         [
                                                              //         'emailP'],
                                                              // 'address':
                                                              //     storedocs[
                                                              //             i]
                                                              //         [
                                                              //         'address'],
                                                              'HajjID':
                                                                  storedocs[i]
                                                                      ['id'],
                                                              // 'password':
                                                              //     storedocs[
                                                              //             i]
                                                              //         [
                                                              //         'password'],
                                                              // 'phoneNumber':
                                                              //     storedocs[
                                                              //             i]
                                                              //         [
                                                              //         'phoneNumberP'],
                                                              //  'seatingCapacity': storedocs[i]
                                                              // ['capacity'],
                                                            });

// This will delete the pilgrim account from the collection with pilgrims pending bookings

                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Bookings')
                                                                .doc(storedocs[
                                                                        i][
                                                                    'UID']) // مفروض حق الحاج نفس لما سجل
                                                                .delete();
                                                          });
                                                        },
                                                        child:
                                                            const Text("Yes")),
                                                  ],
                                                );
                                              });
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Accept'),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.0)),
                                        )),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Reject Pilgrim"),
                                                  content: Text(
                                                      'Are you sure you want to reject pilgrim\'s booking request?'),
                                                  // content: TextField(
                                                  //   controller: _controller,
                                                  //   //  errorText: _errorText,
                                                  //   maxLines: 7,
                                                  //   onChanged: (value) {
                                                  //     rejectionReason =
                                                  //         value;
                                                  //   },
                                                  //   decoration:
                                                  //       InputDecoration(
                                                  //     hintText:
                                                  //         "Enter reason of rejection",
                                                  //   ),
                                                  // ),
                                                  actions: [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0)),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF455D83)),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Cancel')),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0)),
                                                        backgroundColor:
                                                            Color(0xFF455D83),
                                                      ), // background
                                                      onPressed: () {
                                                        //When campaign presses Reject , i think notification caller should be here
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'BOOKING COLLECTION??????')
                                                              .doc(storedocs[i]
                                                                  ['UID'])
                                                              .delete();
                                                          _firestore
                                                              .collection(
                                                                  'RejectedPilgrim') // Why should i delete it then add it to a rejected collection??
                                                              // another campaign might accapt it......
                                                              .add({
                                                            'namePilgrim':
                                                                storedocs[i][
                                                                    'namePilgrim'],
                                                            'status':
                                                                'rejected',
                                                          });
                                                        });
                                                      },
                                                      child: const Text("Yes"),
                                                    )
                                                  ],
                                                );
                                              });
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.cancel_rounded,
                                                color: Colors.redAccent),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                            ),
                                            Text('Reject'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )));
              }))
    ])));
  }
}
