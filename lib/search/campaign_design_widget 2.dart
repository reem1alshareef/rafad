import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import 'package:rafad1/search/user1.dart';

import '../widgets/my_button.dart';

class UsersDesignWidget extends StatefulWidget {

  Users? model;
  BuildContext? context;
  

  UsersDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<UsersDesignWidget> createState() => _UsersDesignWidgetState();
}

class _UsersDesignWidgetState extends State<UsersDesignWidget> {
  final _firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
                                    elevation: 2,
                                    initialPadding:
                                        const EdgeInsets.only(bottom: 7, top: 7),
                                    baseColor: Colors.blueGrey[50],
                                    expandedColor: Colors.blueGrey[50],
                                    //key: cardA,
                                    title: Text(
                                      widget.model!.name!,
                                    ),
                                    subtitle: const Text(
                                      "Click to view campaign's details",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    children: [
                                      const Divider(
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
                                                      const Text(
                                                        'Email:',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        widget.model!.email!,
                                                        style: const TextStyle(
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
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Address:',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        widget.model!.address!,
                                                        style: const TextStyle(
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
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Commercial ID:',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        widget.model!.commercial_ID!,
                                                        style: const TextStyle(
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
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Phone Number:',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        widget.model!.phoneNumber!,
                                                        style: const TextStyle(
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
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Seating Capacity:',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        widget.model!.seatingCapacity!,
                                                        style: const TextStyle(
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
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Description:',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        widget.model!.description!,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ]
                                                )
                                                ]
                                                )
                                                )
                                                )
                                                ),
                                                MyButton(
                              color: const Color(0xFF455D83),
                              title: 'book',
                              onPressed: () async {
                                int counter =
                                    int.parse(widget.model!.seatingCapacity!) -
                                        1;

                                FirebaseFirestore.instance
                                    .collection('AcceptedCampaigns')
                                    .doc(widget.model!.UID!)
                                    .update({
                                  'seatingCapacity': counter.toString(),
                                });
                                _firestore
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection("pilgrimCampaigns")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .set(
                                  {
                                    'bookStatus': 'pending',
                                    'campaignID': widget.model!.UID!,
                                    'name': widget.model!.name!,
                                  },
                                );

                                DocumentSnapshot variable = await _firestore
                                    .collection('Pilgrims-Account')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();
                                String name = variable['name'];
                                String email = variable['email'];
                                String number = variable['number'];
                                String disease = variable['disease'];
                                String hajId = variable['hajId'];
                                String pharma = variable['pharma'];

                                _firestore
                                    .collection("AcceptedCampaigns")
                                    .doc(widget.model!.UID!)
                                    .collection("pilgrimsRequest")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .set(
                                  {
                                    'bookStatus': 'pending',
                                    'pilgrimID':
                                        FirebaseAuth.instance.currentUser?.uid,
                                    'name': name,
                                    'number': number,
                                    'email': email,
                                    'disease': disease,
                                    'hajId': hajId,
                                    'pharma': pharma
                                  },
                                );
                              },
                            ) ////////////////buton
                                                ]
                                                );
                                                
  }
}