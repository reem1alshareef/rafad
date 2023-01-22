import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future review_rate() async{
    if (_review.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
      content: Text('Submitting data..')),
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
        appBar: AppBar(
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),
        body: Center(
          child: Form(
            key: _review,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rating: $rating'

              ),
              RatingBar.builder(
                minRating: 1,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber,),
                updateOnDrag: true,
                onRatingUpdate: (rating) => setState(() {
                  this.rating = rating;
                }),
              ),
              
              TextFormField(
                          maxLines: 3,
                          maxLength: 100,
                          
                          inputFormatters: [
                            FilteringTextInputFormatter.deny
                            (RegExp(r"\s\s"),)
                          ],
                          
                          //controller: _descController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.grey[500],) ,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              review = value;
                            });
                          },
                          decoration: const InputDecoration(labelText: 'Please write your review here'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Review is required!';
                            }
                            if(textValue.length<20){
                              return 'Review should be 10 characters at least';
                            }
                            
                            //return null;
                            if(textValue.trim().isEmpty){
                            return "Review cannot be empty.";
                            }

                            return null;
                          }
                           ),
                            MyButton(
                          color: const Color(0xFF455D83),
                          title: 'Submit',
                          onPressed: review_rate,
                        ),
            ],
          ),


        ),
        
        )
        
        
        
        
        );
  }
}