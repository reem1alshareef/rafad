import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/my_button.dart';

class RateReview extends StatefulWidget {
  const RateReview({super.key});

  @override
  State<RateReview> createState() => _RateReviewState();
}

class _RateReviewState extends State<RateReview> {

  double rating = 0;
  String? review;
  final _review = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Pilgrims-Account")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("pilgrimCampaigns")
        .where('bookStatus', isEqualTo: 'Confirmed')
        .snapshots();

    return Scaffold(
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
                                          "assests/images/kaaba.png"),
                                      backgroundColor: Color(0xFF788AA4),
                                    ),
                                    title: Text(
                                      storedocs[i]['name'],
                                    ),
                                    subtitle: Text(
                                      "Click to view",
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
                                                  child: Column(children: [
                                                    Text(
                                                      'Campaign Name: ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['name'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 109, 94, 19),
                                                      ),
                                                    ),
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
        builder: (BuildContext context) {
          return AlertDialog(
            title: Form(
              key: _review,
              child: Column(
                children: <Widget>[
                  const Text(
                   'Please rate and review this campaign.',
                   style: TextStyle(fontSize: 15)),

                  const SizedBox(height: 20,),

                  buildRating(),

                  const SizedBox(height: 20,),

                  TextFormField(
                    maxLength: 30,
                    maxLines: 2,
                     textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              review = value;
                            });
                          },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Review is required!';
                            }
                            if(textValue.length<5){
                              return 'Review should be 5 characters at least';
                            }
                            if(textValue.trim().isEmpty){
                            return "Review cannot be empty.";
                            }
                            if(rating == 0){
                              return "Rating should be greater than 0!"
                              ;}
                            return null;
                          }
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                //color:  Colors.green,
                //title: 'Save',
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green,),
                onPressed: () async {
                  await FirebaseFirestore.instance
                            .collection("Rate")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                           'rating': rating,
                           'review': review,
                           'campaignID': storedocs[i]['campaignID'],
                           'UID': FirebaseAuth.instance.currentUser!.uid,}, SetOptions(merge: true));
                    Navigator.pop(context);
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white , fontSize: 20),),
                  ),
              TextButton(
                //color: Colors.red,
                //title: 'Cancel',
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.white , fontSize: 20),),
              ),
            ],
          );
        });
                                            },
                                            child: Column(
                                              children: const <Widget>[
                                                Icon(Icons.star,
                                                    color:
                                                              Color(0xFF455D83)),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                                ),
                                                Text('Rate'),
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
  Widget buildRating() => RatingBar.builder(
                                                      minRating: 1,
                                                      itemSize: 30,
                                                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                                                      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
                                                      updateOnDrag: true,
                                                      onRatingUpdate: (rating) => setState(() {
                                                      this.rating = rating;
                                                 }),
                                                 
                                                    );
}

  
