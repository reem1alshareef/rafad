import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class CampaignAddAnouncement extends StatefulWidget {
  const CampaignAddAnouncement({super.key});

  @override
  State<CampaignAddAnouncement> createState() => _CampaignAddAnouncement();
}

class _CampaignAddAnouncement extends State<CampaignAddAnouncement> {
  final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
      .collection('AcceptedCampaigns')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Announcements')
      .snapshots();
  late final List storedocs = [];

  final TextEditingController _descController = TextEditingController();
  final _addTitleKey = GlobalKey<FormState>();
  final _addDesKey = GlobalKey<FormState>();
  String? description;
  //TimeOfDay time=TimeOfDay(hour: 00, minute: 00);
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  late DateTime datetime;
  String title = "no information available";

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future addActivity() async {
    print('reached add activity');
    if (_addTitleKey.currentState!.validate()) {
      print('reached condition');
      date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("AcceptedCampaigns")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Announcements')
          .add(
        {
          'title': title,
          'time': Timestamp.fromDate(DateTime.now()),
          //'activityID':document.documentID,
        },
      );
      await docRef.set({
        'announcementID': docRef.id,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    //int theHour;

    return Scaffold(
      appBar: AppBar(title: Text(
                      'Announcements',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
                    ),),
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [

            // Center(
            //     child: Padding(
            //         padding: EdgeInsets.all(16.0),
            //         child: Text(
            //           'Announcements',
            //           style:
            //               TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            //         ))),

            const SizedBox(height: 37),
            const SizedBox(
              width: 10,
              height: 30,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  border: Border.all(
                    color: Color.fromARGB(255, 249, 250, 251),
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(
                      30), //was 12 ---------------------------------------------------------------------------------------------------------
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),

                    //add activity start
                    Row(children: [
                      const SizedBox(width: 10),

                      //add title
                      Flexible(
                          child: Form(
                              key: _addTitleKey,

                              child: Column(children: [
                                





                                // child: //jjjjjjj
                                  TextFormField(
                                //key: _addTitleKey,
                                maxLines: 1,
                                maxLength: 15,

                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  )
                                ],

                                //controller: _descController,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    title = value;
                                  });
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Title'),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (textValue) {
                                  if (textValue == null || textValue.isEmpty) {
                                    return 'Title is required!';
                                  }
                                  if (textValue.length < 5) {
                                    return 'Title should be 5 characters at least';
                                  }

                                  //return null;
                                  if (textValue.trim().isEmpty) {
                                    return "Title cannot be empty.";
                                  }

                                  if (!textValue.contains(RegExp(r'[a-z]'))) {
                                    return ("Title must contain letters");
                                  }

                                  return null;
                                },
                              ),
                              
                              TextFormField(

                                  maxLines: 1,
                                maxLength: 15,

                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s\s"),
                                  )
                                ],

                                //controller: _descController,
                                cursorColor: Colors.white,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    title = value;
                                  });
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Description'),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (textValue) {
                                  if (textValue == null || textValue.isEmpty) {
                                    return 'Description is required!';
                                  }
                                  if (textValue.length < 5) {
                                    return 'Description should be 5 characters at least';
                                  }

                                  //return null;
                                  if (textValue.trim().isEmpty) {
                                    return "Description cannot be empty.";
                                  }

                                  if (!textValue.contains(RegExp(r'[a-z]'))) {
                                    return ("Description must contain letters");
                                  }

                                  return null;
                                },

                                ),






                              ],), 






                              // child: //jjjjjjj
                              //     TextFormField(
                              //   //key: _addTitleKey,
                              //   maxLines: 1,
                              //   maxLength: 15,

                              //   inputFormatters: [
                              //     FilteringTextInputFormatter.deny(
                              //       RegExp(r"\s\s"),
                              //     )
                              //   ],

                              //   //controller: _descController,
                              //   cursorColor: Colors.white,
                              //   style: TextStyle(
                              //     color: Colors.grey[500],
                              //   ),
                              //   textInputAction: TextInputAction.done,
                              //   keyboardType: TextInputType.text,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       title = value;
                              //     });
                              //   },
                              //   decoration:
                              //       const InputDecoration(labelText: 'Title'),
                              //   autovalidateMode:
                              //       AutovalidateMode.onUserInteraction,
                              //   validator: (textValue) {
                              //     if (textValue == null || textValue.isEmpty) {
                              //       return 'Title is required!';
                              //     }
                              //     if (textValue.length < 5) {
                              //       return 'Title should be 5 characters at least';
                              //     }

                              //     //return null;
                              //     if (textValue.trim().isEmpty) {
                              //       return "Title cannot be empty.";
                              //     }

                              //     if (!textValue.contains(RegExp(r'[a-z]'))) {
                              //       return ("Title must contain letters");
                              //     }

                              //     return null;
                              //   },
                              // )
                              
                              
                              
                              
                              
                              )
                              ),

                      //Flexible(
                        //  child: Form(key: _addDesKey, child: TextFormField())),

                      IconButton(
                          onPressed: () {
                            print('reached submition');
                            addActivity();
                          },
                          icon: const Icon(Icons.add_circle))
                    ]),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),

//add activity end

//data output

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: StreamBuilder<QuerySnapshot>(
                    stream: dataStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        // TODO : add snackbar
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
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
                              (i) => Column(
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.blueGrey[50],
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 249, 250, 251),
                                              width: 8,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        storedocs[i]['title']),
                                                  ),
                                                  //SizedBox(width: 40,),

                                                  const Icon(
                                                      Icons.calendar_today),
                                                  Text(
                                                      ' ${storedocs[i]['time'].toDate().day}/${storedocs[i]['time'].toDate().month}/${storedocs[i]['time'].toDate().year} '),

                                                  const Icon(Icons.timer),
                                                  Text(
                                                      ' ${storedocs[i]['time'].toDate().hour}:${storedocs[i]['time'].toDate().minute}'),

                                                  // IconButton(
                                                  //     color: Color.fromARGB(
                                                  //         255, 255, 0, 0),
                                                  //     onPressed: () {
                                                  //       FirebaseFirestore
                                                  //           .instance
                                                  //           .collection(
                                                  //               "AcceptedCampaigns")
                                                  //           .doc(FirebaseAuth
                                                  //               .instance
                                                  //               .currentUser!
                                                  //               .uid)
                                                  //           .collection(
                                                  //               "Activities")
                                                  //           .doc(storedocs[i]
                                                  //               ['activityID'])
                                                  //           .delete();
                                                  //     },
                                                  //     icon: Icon(Icons.cancel))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )),
                                    ],
                                  )));
                    }))
          ],
        ),
      ),
    ));
  }
}
