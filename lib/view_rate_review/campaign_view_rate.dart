import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewRateReview extends StatefulWidget {
  const ViewRateReview({super.key});

  @override
  State<ViewRateReview> createState() => _ViewRateReviewState();
}

class _ViewRateReviewState extends State<ViewRateReview> {

  double rating = 0;

  final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Rate")
        .where('campaignID', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Back"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
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
                      a['UID'] = document.id;
                    }).toList();
                    return Column(
                        children: List.generate(
                            storedocs.length,
                            (i) => SingleChildScrollView(
                              child: ListTile(
                                title: buildRating(),
                                subtitle: storedocs[i]['review'],
                              ),
                            )
                            )
                            );
                            }
                            )
                            )
                            ]
                            )
                            )
    );
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