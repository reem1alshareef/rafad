/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future review_rate() async{
  DocumentSnapshot variable = await FirebaseFirestore.instance
  .collection('Pilgrims-Account')
  .doc(FirebaseAuth.instance.currentUser?.uid)
  .collection('pilgrimCampaigns')
  //.doc()
  .where('bookStatus', isEqualTo: 'Accepted')
  .();

  String name = variable ['name'];
  String campaignID = variable ['campaignID'];
  String bookStatus = variable ['bookStatus'];

  if(bookStatus != 'Confirmed')
  {
    return showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  'You must confirm your booking with this campaign first.'),
            );
          });

  }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Form(
              key: _review,
              child: Column(
                children: <Widget>[
                  const Text(
                   'Please leave a review.',
                   style: TextStyle(fontSize: 20)),
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
                            //return null;
                            if(textValue.trim().isEmpty){
                            return "Review cannot be empty.";
                            }
                            return null;
                          }
                  ),
                  const Text(
                   'Please leave a star rating.',
                   style: TextStyle(fontSize: 20)),

                   const SizedBox(height: 32,),

                   buildRating(),
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
                           'campaignID': campaignID,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Profile"),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
      ),
      body: Container(
        child: MyButton(
          color: const Color(0xFF455D83),
          title: 'Add Description',
          onPressed: review_rate,
        )
      ),
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
}*/