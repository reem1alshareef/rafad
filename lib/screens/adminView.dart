import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';

class View extends StatefulWidget {
  const View({super.key});

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('Campaign-Account').snapshots();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Registration requests'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
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
                                      child: Image.asset(
                                          "assests/images/kaaba.png"),
                                      backgroundColor: Color(0xFF788AA4),
                                    ),
                                    title: Text(
                                      storedocs[i]['nameCampaign'],
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
                                                        storedocs[i]['emailC'],
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
                                                          ['commercialID'],
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
                                                          ['phoneNumberC'],
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
                                                      storedocs[i]['capacity'],
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
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceAround,
                                        buttonHeight: 52.0,
                                        buttonMinWidth: 90.0,
                                        children: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.0)),
                                            )),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Accept Request"),
                                                      content: const Text(
                                                          "Are you sure you want to accept?"),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF455D83)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Cancel")),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF455D83)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(
                                                                  () async {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Campaign-Account')
                                                                    .doc(storedocs[
                                                                            i]
                                                                        ['UID'])
                                                                    .delete(); // to remove it from UI
                                                                _firestore
                                                                    .collection(
                                                                        'AcceptedCampaigns')
                                                                    .doc(storedocs[
                                                                            i]
                                                                        ['UID'])
                                                                    .set({
                                                                  // To add it to the accepted collection
                                                                  'UID':
                                                                      storedocs[
                                                                              i]
                                                                          [
                                                                          'UID'],
                                                                  'description':
                                                                      'no description',
                                                                  'status':
                                                                      'accepted',
                                                                  'name': storedocs[
                                                                          i][
                                                                      'nameCampaign'],
                                                                  'email':
                                                                      storedocs[
                                                                              i]
                                                                          [
                                                                          'emailC'],
                                                                  'address':
                                                                      storedocs[
                                                                              i]
                                                                          [
                                                                          'address'],
                                                                  'commercial_ID':
                                                                      storedocs[
                                                                              i]
                                                                          [
                                                                          'commercialID'],
                                                                  'phoneNumber':
                                                                      storedocs[
                                                                              i]
                                                                          [
                                                                          'phoneNumberC'],
                                                                  'seatingCapacity':
                                                                      storedocs[
                                                                              i]
                                                                          [
                                                                          'capacity'],
                                                                });
                                                              });
                                                            },
                                                            child: const Text(
                                                                "Yes")),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                ),
                                                Text('Accept'),
                                              ],
                                            ),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.0)),
                                            )),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Reject Request"),
                                                      content: TextField(
                                                        maxLines: 7,
                                                        onChanged: (value) {
                                                          rejectionReason =
                                                              value;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter reason of rejection",
                                                        ),
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF455D83)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text('Cancel')),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0)),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF455D83),
                                                          ), // background
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            setState(() async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Campaign-Account')
                                                                  .doc(storedocs[
                                                                      i]['UID'])
                                                                  .delete(); // to remove it from UI
                                                              _firestore
                                                                  .collection(
                                                                      'RejectedCampaigns')
                                                                  .doc(storedocs[
                                                                      i]['UID'])
                                                                  .set({
                                                                // to add it to rejected collection
                                                                'UID':
                                                                    storedocs[i]
                                                                        ['UID'],
                                                                'description':
                                                                    '',
                                                                'name': storedocs[
                                                                        i][
                                                                    'nameCampaign'],
                                                                'email':
                                                                    storedocs[i]
                                                                        [
                                                                        'emailC'],
                                                                'address':
                                                                    storedocs[i]
                                                                        [
                                                                        'address'],
                                                                'commercial_ID':
                                                                    storedocs[i]
                                                                        [
                                                                        'commercialID'],
                                                                'phoneNumber':
                                                                    storedocs[i]
                                                                        [
                                                                        'phoneNumberC'],
                                                                'seatingCapacity':
                                                                    storedocs[i]
                                                                        [
                                                                        'capacity'],
                                                                'reason':
                                                                    rejectionReason,
                                                                'status':
                                                                    'rejected',
                                                              });
                                                            });
                                                          },
                                                          child: const Text(
                                                              "Submit"),
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
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
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
