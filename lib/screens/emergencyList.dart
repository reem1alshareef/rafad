import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/PolylineScreen.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/widgets/emButton.dart';
import 'package:rafad1/screens/LocationService.dart';
import 'package:rafad1/screens/emergency.dart';
import 'package:rafad1/screens/LocationService.dart';
import 'package:rafad1/screens/pilgLocation.dart';


class emergencyList extends StatefulWidget {
  static const String screenRoute = 'emergencyList.dart';
  const emergencyList({super.key});

  @override
  _emergencyListState createState() => _emergencyListState();
}
class _emergencyListState extends State<emergencyList> {
  final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();


  //  DocumentSnapshot variable = await _firestore
  //  .collection('Pilgrims-Account')
  //   .doc(storedocs[i]['UID']).get(
  //    {
  //   double latitude = variable['latitude'];
  //   double  longitude = variable['longitude'];
  //   },
  //   );
  

  
  @override
void DataStreams() async {
  DocumentSnapshot variable = await _firestore
                                    .collection('AcceptedCampaigns')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();
                                String pilgrimID = variable['pilgrimID'];
    await for (var snapshot
        in _firestore.collection('pilgrimEmrgency').snapshots()) {
      
      for (var pilgrim in snapshot.docs) {
        print(pilgrim.data());
      }
    }
  }

  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('pilgrimEmrgency')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('list of requesting pilgrims emergency'),
        backgroundColor:  Color.fromARGB(255, 184, 20, 20),
        elevation: 0,
      ),
      
            body: SingleChildScrollView(
            child: Column(children: [
              
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
                                  child: Image.asset("assests/images/emergrncyIcon.png"),
                                  backgroundColor: Color(0xFF788AA4),
                                ),
                                title: Text(
                                  storedocs[i]['name'],
                                ),
                                subtitle: Text(
                                  "information of Pilgrim who need emergency",
                                  style: TextStyle(
                                      fontSize: 11, color: Color.fromARGB(255, 184, 20, 20)),
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
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s Phone Number:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['number'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s Diseases:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['disease'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                Text(
                                                  'Pilgrim\'s pharma:  ',
                                                  style: TextStyle(
                                                      color: Color(0xFF455D83),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  storedocs[i]['pharma'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ]),
                                            ),
                                            /////////////////////حق ريتريف الكرنت لوكيشن حق الحاج
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Column(children: [
                                                IconButton(
                                                  icon: Icon(
                                                    (Icons.location_history_sharp),
                                                    color: Color.fromARGB(255, 160, 10, 10),
                                                    ),
                                                    onPressed: () async {
                                                      ///////////توديه للماب 
                                                      
Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return const pilgLocation();
              }));
//////////////////

                                                    },
                                                    )
                                              ]),
                                            ),
                                            //////////////////////////////// هنا نهايته
                                          ]),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )));
              },
              ),
              )
              
    ],
    )
    )

    );
    } //throw UnimplementedError();
}
