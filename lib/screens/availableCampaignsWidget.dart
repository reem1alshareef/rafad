import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/view_rate_review/rating_model.dart';
//import 'package:herfaty/constants/color.dart';
//import 'package:herfaty/models/ratingModel.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

import '../search/user1.dart';
import '../view_rate_review/campaign_view_rate.dart';
import '../widgets/my_button.dart';


class availableCampaignsWidget extends StatefulWidget {
  const availableCampaignsWidget({
    Key? key,
    required this.itemIndex,
    required this.model,

  }) : super(key: key);

  final int itemIndex;
  final Users model;

  @override
  State<availableCampaignsWidget> createState() => _availableCampaignsWidgetState();
}

class _availableCampaignsWidgetState extends State<availableCampaignsWidget> {

  final _firestore = FirebaseFirestore.instance;
  
  
  @override
  Widget build(BuildContext context) {
    double average = double.parse(widget.model.avrgRating!);
    double people = double.parse(widget.model.numberOfPeople!);

    Size size =
        MediaQuery.of(context).size; //to get the width and height of the app
    return ExpansionTileCard(
                                    elevation: 2,
                                    initialPadding:
                                        const EdgeInsets.only(bottom: 7, top: 7),
                                    baseColor: Colors.blueGrey[50],
                                    expandedColor: Colors.blueGrey[50],
                                    //key: cardA,
                                    title: Text(
                                      widget.model.name!,
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
                                                        widget.model.email!,
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
                                                        widget.model.address!,
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
                                                        widget.model.commercial_ID!,
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
                                                        widget.model.phoneNumber!,
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
                                                        widget.model.seatingCapacity!,
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
                                                        widget.model.description!,
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
                                                RatingStars(
                                                  rating: double.parse(widget.model!.avrgRating!), 
                                                  editable: false,
                                                  color: Colors.amber,
                                                  iconSize: 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => {
                                                        Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                        builder: (context) =>
                                                      ratingsList( campaignId: widget.model.UID! , averageShopRating: average,  numberOfRatings: people)))
                                },
                                child: Text(
                                   widget.model.numberOfPeople!,
                                  style: TextStyle(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                                                  ),             
                                                MyButton(
                                        color: const Color(0xFF455D83),
                                        title: 'book',
                                        onPressed:  () async  {
                                        _firestore.collection("AcceptedCampaigns").doc(widget.model.UID).collection("pilgrimsRequest").add({
                                                'bookStatus': 'booked',
                                                ///'pilgrimID': FirebaseAuth.instance.currentUser?.uid,
                                                
                                                //User user = FirebaseAuth.instance.currentUser;
                                               // DocumentSnapshot snap = FirebaseFirestore.instance.collection('Pilgrims-Account').doc(user.uid).get();
                                                // String 'pilgrinID' = snap['uid'];
                                                // String 'name' = snap['name'];
                                                // String 'number' = snap['number'];
                                                // String 'hajId' = snap['hajId'];
                                                // String 'pharma' = snap['pharma'];
                                                // 'name':  storedocsP[i]['name'],
                                                // 'number': storedocsP[i]['number'],//   في الكولكشن حقها باقي هنا اسوي ريتريف لبيانات الحاج من الكلوكشن حقه واحطها عند الحمله
                                                // 'hajId': storedocsP[i]['hajId'],
                                                // 'pharma': storedocsP[i]['pharma'],
                                              },
                                              );
                                        FirebaseFirestore.instance.collection('AcceptedCampaigns').doc(widget.model.UID).update({'seatingCapacity': FieldValue.increment(-1),});

                                        _firestore.collection("Pilgrims-Account").doc(FirebaseAuth.instance.currentUser?.uid).collection("pilgrimCampaigns").add({
                                                'bookStatus': 'pending',
                                                'campaignID': widget.model.UID,
                                              },
                                              );
                                        },
                                       )
                                                ]
                                                );
  }}