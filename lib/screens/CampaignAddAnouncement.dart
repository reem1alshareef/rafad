import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rafad1/screens/announcementLocation.dart';
import 'package:rafad1/screens/showLocation.dart';
import 'package:rafad1/widgets/my_button.dart';

import '../services/local_push_notification.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class CampaignAddAnouncement extends StatefulWidget {
  const CampaignAddAnouncement({super.key});

  @override
  State<CampaignAddAnouncement> createState() => _CampaignAddAnouncement();
}

class _CampaignAddAnouncement extends State<CampaignAddAnouncement> {
  bool isLoading = false;
  final _firestore = FirebaseFirestore.instance;

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    storeNotificationToken();

    //   FirebaseMessaging.instance.subscribeToTopic('subscription');
  }

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
  late LatLng location;

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  Future addActivity() async {
    print('reached add activity');
    if (_addTitleKey.currentState!.validate()) {
      print('reached condition');
      print(location.latitude);
      date = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("AcceptedCampaigns")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('Announcements')
          .add(
        {
          'title': title,
          'time': Timestamp.fromDate(DateTime.now()),
          'description': description,
          'latitude': location.latitude,
          'longitude': location.longitude,
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
        appBar: AppBar(
          title: Text(
            'Announcements',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
          ),
        ),
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

                            child: Column(
                              children: [
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
                                    color: Colors.black,
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
                                    if (textValue == null ||
                                        textValue.isEmpty) {
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
                                      description = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Description'),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (textValue) {
                                    if (textValue == null ||
                                        textValue.isEmpty) {
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

                                Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(15.0),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                      ),
                                      color: Colors.blueAccent,
                                    ),
                                    child: Center(
                                        child: Row(
                                      children: [
                                        Center(child: Text('Choose Location'),),
                                        Center(child:

                                        IconButton(
                                            onPressed: () async {
                                              location = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        announcementLocation(),
                                                  ));
                                            },
                                            icon: Icon(Icons.pin_drop_rounded)),)
                                      ],
                                    ))),

                                MyButton(
                                    color: Color.fromARGB(255, 48, 48, 122),
                                    title: 'Submit',
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                title: Column(
                                                  children: [
                                                    Center(
                                                        child: Text(
                                                            "Sending Announcement can't")),
                                                    Center(
                                                      child: Text("be undone"),
                                                    )
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        addActivity().then(
                                                            (value) =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'Cancel')),
                                                    child: Text('Send'),
                                                  ),
                                                ]);
                                          });
                                      //addActivity();
                                    })
                              ],
                            ),

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
                          )),

                          //Flexible(
                          //  child: Form(key: _addDesKey, child: TextFormField())),

                          // IconButton(
                          //     onPressed: () {
                          //       print('reached submition');
                          //       addActivity();
                          //     },
                          //     icon: const Icon(Icons.add_circle))
                        ]),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),

//add activity end

//data output

                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: dataStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            // TODO : add snackbar
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                  (i) => SingleChildScrollView(
                                    child: ExpansionTileCard(
                                      elevation: 2,
                                      initialPadding:
                                      EdgeInsets.only(bottom: 7, top: 7),
                                      baseColor: Colors.blueGrey[50],
                                      expandedColor: Colors.blueGrey[50],
                                      //key: cardA,
                                      leading: CircleAvatar(
                                        child: Icon(Icons.circle_notifications_rounded),
                                        backgroundColor: Color(0xFF788AA4),
                                      ),
                                      title: Text(
                                        storedocs[i]['title'],
                                      ),
                                      subtitle: Text(
                                        "Click to view announcement's details",
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
                                                  MyButton(color: Color.fromARGB(255, 48, 48, 122), title: 'Show Location', onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => showLocation(
                  latitude: storedocs[i]['latitude'],
                  longitude: storedocs[i]['longitude'],
                ),));
                                                  }),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Description:  ',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF455D83),
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                        Text(
                                                          storedocs[i]['description'],
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
                                                        'Date:  ',
                                                        style: TextStyle(
                                                            color:
                                                            Color(0xFF455D83),
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                      Text(
                                                        ' ${storedocs[i]['time'].toDate().day}/${storedocs[i]['time'].toDate().month}/${storedocs[i]['time'].toDate().year} ',
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
                                                        'Time:  ',
                                                        style: TextStyle(
                                                            color:
                                                            Color(0xFF455D83),
                                                            fontWeight:
                                                            FontWeight.w500),
                                                      ),
                                                      Text(
                                                        ' ${storedocs[i]['time'].toDate().hour}:${storedocs[i]['time'].toDate().minute}',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ]),
                                                  ),
                                                ]),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )























                                /*Column(












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
                                                        child: Text(storedocs[i]
                                                            ['title']),
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
                                      )*/



















                              ));
                        }))
              ],
            ),
          ),
        ));
  }
}
