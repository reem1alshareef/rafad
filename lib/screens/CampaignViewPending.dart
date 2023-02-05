import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_accept.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//import 'package:rafad1/screens/LoginPage.dart';
class ViewPending extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';

  @override
  _ViewPendingState createState() => _ViewPendingState();
}

class _ViewPendingState extends State<ViewPending> {
  void initState() {
    super.initState();
    //NotificationAccept.init();
  }

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
// if (FirebaseFirestore.instance.collection('Pilgrims-Account').doc() ==
//         FirebaseFirestore.instance
//             .collection('AcceptedCampaigns')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .collection('pilgrimsRequest')
//             .doc())
//              FirebaseFirestore.instance.collection('pilgrimsRequest').doc();
    // DocumentReference doc_ref = FirebaseFirestore.instance
    //     .collection('AcceptedCampaigns')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection('pilgrimsRequest').

    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('pilgrimsRequest')
        .snapshots();

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
                  a['pilgrimID'] = document.id;
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
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
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
                                                Text(
                                                  'Pilgrim\'s email:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['email'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s Phone Number:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['number'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s ID:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['hajId'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s Diseases:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['disease'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ]),
                                            ),
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
                                                        onPressed: () async {
                                                          // This whole code will be when campaign presses Accept
                                                          // Albatouls Notification

                                                          DocumentSnapshot
                                                              variable =
                                                              await _firestore
                                                                  .collection(
                                                                      'AcceptedCampaigns')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser
                                                                      ?.uid)
                                                                  .get();
                                                          String name =
                                                              variable['name'];

                                                          // await NotificationAccept
                                                          //     .showNotification(
                                                          //         id: 0,
                                                          //         title:
                                                          //             '$name Campaign Message',
                                                          //         body:
                                                          //             'Congratulations!, you have been accepted into $name campaign. We wish you a blessed Hajj');

                                                          Navigator.of(context)
                                                              .pop();

                                                          setState(() async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'AcceptedCampaigns')
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    'pilgrimsRequest')
                                                                .doc(storedocs[
                                                                        i][
                                                                    'pilgrimID'])
                                                                .delete();
// delete from view_booking UI
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Pilgrims-Account")
                                                                .doc(storedocs[
                                                                        i][
                                                                    'pilgrimID'])
                                                                .collection(
                                                                    "pilgrimCampaigns")
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                                .update({
                                                              'bookStatus':
                                                                  'Accepted'
                                                            });
                                                            ///////////////////////////////كود يحفظ اي دي الحمله باكاونت الحاج عشان نعلاف الحاج الحين يمشي مع اي حمله
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Pilgrims-Account")
                                                                .doc(storedocs[
                                                                        i][
                                                                    'pilgrimID']).update({
                                                                      'campaignID' :FirebaseAuth.instance.currentUser?.uid,
                                                                    },
                                                                    );
                                                              ////////////////////
                                                              ///عشان اجيب اي دي الحجاج المقبولين مع الحمله
                                                              // await FirebaseFirestore
                                                              //   .instance
                                                              //   .collection(
                                                              //       "AcceptedCampaigns")
                                                              //   .doc(storedocs[
                                                              //           i][
                                                              //       'pilgrimID']).update({
                                                              //         'pilgrimID' :storedocs[
                                                              //           i][
                                                              //       'pilgrimID'],
                                                              //       },
                                                              //       );
                                                              ///
                                                            _firestore
                                                                .collection(
                                                                    'AcceptedCampaigns')
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                                .collection(
                                                                    'AcceptedPilgrims')
                                                                .doc(storedocs[
                                                                        i][
                                                                    'pilgrimID']) // for this specific campaign
                                                                .set({
                                                              'name':
                                                                  storedocs[i]
                                                                      ['name'],
                                                              'email':
                                                                  storedocs[i]
                                                                      ['email'],
                                                              'disease':
                                                                  storedocs[i][
                                                                      'disease'],
                                                              'number':
                                                                  storedocs[i][
                                                                      'number'],
                                                              'bookStatus':
                                                                  'Accepted',
                                                              'hajId':
                                                                  storedocs[i]
                                                                      ['hajId'],
                                                              'pharma':
                                                                  storedocs[i][
                                                                      'pharma'],
                                                              'pilgrimID':
                                                                  storedocs[i][
                                                                      'pilgrimID']
                                                            });
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
                                                      "Reject Request"),
                                                  content: Text(
                                                      'Are you sure you want to reject pilgrim\'s booking request?'),
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
                                                      onPressed: () async {
                                                        await NotificationAccept
                                                            .showNotification(
                                                                id: 0,
                                                                title:
                                                                    'campaign message',
                                                                body:
                                                                    'Sorry!, your requst is rejected in our campaign');

                                                        //When campaign presses Reject , i think notification caller should be here
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'AcceptedCampaigns')
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  'pilgrimsRequest')
                                                              .doc(storedocs[i]
                                                                  ['pilgrimID'])
                                                              .delete();

                                                          // delete from view_booking UI
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Pilgrims-Account")
                                                              .doc(storedocs[i]
                                                                  ['pilgrimID'])
                                                              .collection(
                                                                  "pilgrimCampaigns")
                                                              .doc(storedocs[i]
                                                                  ['pilgrimID'])
                                                              .delete();

                                                          _firestore
                                                              .collection(
                                                                  'AcceptedCampaigns')
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .collection(
                                                                  'RejectedPilgrims')
                                                              .doc(storedocs[i]
                                                                  ['pilgrimID'])
                                                              .set({
                                                            'name': storedocs[i]
                                                                ['name'],
                                                            'email':
                                                                storedocs[i]
                                                                    ['email'],
                                                            'disease':
                                                                storedocs[i]
                                                                    ['disease'],
                                                            'number':
                                                                storedocs[i]
                                                                    ['number'],
                                                            'bookStatus':
                                                                'Rejected',
                                                            'hajId':
                                                                storedocs[i]
                                                                    ['hajId'],
                                                            'pharma':
                                                                storedocs[i]
                                                                    ['pharma'],
                                                            'pilgrimID':
                                                                storedocs[i][
                                                                    'pilgrimID']
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

