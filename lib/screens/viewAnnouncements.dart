import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rafad1/screens/showLocation.dart';
import 'package:rafad1/widgets/my_button.dart';
import 'notification_accept.dart';

class viewAnnouncements extends StatefulWidget {
  const viewAnnouncements({super.key});

  @override
  _viewAnnouncements createState() => _viewAnnouncements();
}

class _viewAnnouncements extends State<viewAnnouncements> {
  void initState() {
    super.initState();
  }

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    
    Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("AcceptedCampaigns")
        .doc('9o5HM6UHV0M20DazLE7RbBTCgVn2')
        .collection("Announcements")
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          title: Text('Campaign Announcements'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 37),

            // Row(
            //   children: [
            //     const SizedBox(width: 10),
            //     Ink(
            //       decoration: const ShapeDecoration(
            //         color: const Color(0xFF455D83),
            //         shape: CircleBorder(),
            //       ),
            //       child: IconButton(
            //         icon: const Icon(Icons.notifications),
            //         tooltip: 'Show Snackbar',
            //         color: const Color.fromARGB(255, 255, 255, 255),
            //         onPressed: () {

            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     const viewAnnouncements()),
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              width: 10,
              height: 30,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
                    print('reached list');
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
















                        // child: Container(
                        //   margin: EdgeInsets.only(bottom: 17),
                        //   child: ListTile(
                        //     title: Text(
                        //       storedocs[i]['title'],
                        //       style: TextStyle(
                        //           color: Color(0xFF455D83), fontSize: 20),
                        //     ),
                        //     trailing:
                        //         Row(mainAxisSize: MainAxisSize.min, children: [
                        //       Text(
                        //         ' Starts at  '
                        //         ' ${storedocs[i]['time'].toDate().hour} : ${storedocs[i]['time'].toDate().minute} ',
                        //         style: TextStyle(
                        //             color: Color(0xFF455D83),
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 17),
                        //       ),
                        //       Icon(Icons.access_time_rounded),
                        //       Text(
                        //         '  ${storedocs[i]['time'].toDate().month} / ${storedocs[i]['time'].toDate().day}',
                        //         style: TextStyle(
                        //             color: Color(0xFF455D83),
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 17),
                        //       ),
                        //       Icon(Icons.calendar_today_rounded)
                        //     ]),
                        //     tileColor: Color.fromARGB(255, 228, 232, 235),
                        //     contentPadding: EdgeInsets.all(17),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20)),
                        //   ),
                        // ),







                      ),
                    ),
                  );
                }),
          )
        ])));
  }
}

