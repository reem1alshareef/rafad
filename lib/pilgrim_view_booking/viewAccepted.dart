import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/my_button.dart';

class viewAccepted extends StatefulWidget {
  const viewAccepted({super.key});

  @override
  State<viewAccepted> createState() => _viewAcceptedState();
}

class _viewAcceptedState extends State<viewAccepted> {

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
                                      "Click to view requests's details ",
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
                                                    const Text(
                                                      'Campaign\'s Name: ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['name'],
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 109, 94, 19),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(children: [
                                      
                            
                                                  ]),
                                                ),
                                              ]),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                )));
                  }))
        ]))




















        /*appBar: AppBar(
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),*/
        /*body: Center(
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
        
        )*/
        
        
        
        
        );
  }
}