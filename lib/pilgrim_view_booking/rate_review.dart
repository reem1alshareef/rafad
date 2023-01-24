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

  Future review_rate() async{
    if (_review.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
      content: Text('Submitting data..')),
    );
  }

  
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Pilgrims-Account")
        .where('UID', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();

    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    //if(snapshot.data!.docs[Index].data()['ChosenCampaignName'] != null){
                    final List storedocs = [];
                    
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map a = document.data() as Map<String, dynamic>;
                      storedocs.add(a);
                      a['UID'] = document.id;
                    }).toList();
                    return Column(
                        children: List.generate(
                            storedocs.length,
                            (i) => 
                            SingleChildScrollView( 
                              
                                                  child: Column(
                                                    children: <Widget>[
                                                    Text(
                                                      'Campaign Name:' 
                                                        ),
                                                        Text(
                                                      storedocs[i]['ChosenCampaignName'] 
                                                        ),
                                                        SizedBox(height: 10,),
                                                    
                                      MyButton(
                                      color: const Color(0xFF455D83),
                                       title: 'Rate',
                                       onPressed: () async {
                                        return showDialog(
                                         context: context,
                                         builder: (context) => AlertDialog(
                                            //title: Text('Rate this campaign'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:  [
                                                const Text(
                                                'Please leave a star rating.',
                                                style: TextStyle(fontSize: 20)),

                                                const SizedBox(height: 32,),

                                                buildRating(),
                                              ],
                                            ),
                                            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.green,),
                onPressed: () async {
                  await FirebaseFirestore.instance
                            .collection("Rate")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set({
                           'rating': rating,
                           //'review': review,
                           'campaignID': storedocs[i]['ChosenCampaignID'],
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
                                         ),);
                                       },
                                      ),
                        MyButton(
                  color: const Color(0xFF455D83),
                  title: 'Review',
                  onPressed: () async {
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
                  )
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
                           //'rating': rating,
                           'review': review,
                           'campaignID': storedocs[i]['ChosenCampaignID'],
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
  },)
 ]
 ),
 )
)
  )
                        ;
}
 )
)
]))
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