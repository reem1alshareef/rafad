import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/search/search_campaign.dart';
import 'package:rafad1/search/search_pilgrim.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

//import '../search/campaign_design_widget.dart';
import '../search/user1.dart';
import '../view_rate_review/campaign_view_rate.dart';
import '../widgets/my_button.dart';
import 'Chat_screen.dart';


//import 'package:rafad1/screens/LoginPage.dart';
class ListOfPilgrim extends StatefulWidget {
//static const String screenRoute = 'logOutPilgrim.dart';
const ListOfPilgrim({super.key});

  @override
  _ListOfPilgrimState createState() => _ListOfPilgrimState();
}

class _ListOfPilgrimState extends State<ListOfPilgrim> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;
  bool isButtonActive = true;////// حق شرط البوتون انه مايسمح للحاج يضغط اكثر من مره
  final _controller = TextEditingController();
  String uid ='';
  double average= 0;
  double people =0;
  User? user;



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool card = false;
  bool isVisible = true;
  bool _submitted = false;
  String? name;

  void _submit() {
    setState(() => _submitted = true);
    if (_errorText == null) {}
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = _controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty ';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('AcceptedCampaigns')
        .snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance
        .collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('AcceptedPilgrims')
        .snapshots();
        
    return Scaffold(
floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF455D83),
          tooltip: 'Chat',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Chat_screen()),
            );
          },
          child: Image.asset('assests/images/chat.png', height: 35),
        ),

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Your Pilgrims'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) =>
                      SearchPilgrim()));
              },
            )
          ],
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
                                  child: ExpansionTileCard(
                                   
        elevation: 2,
        initialPadding: const EdgeInsets.only(bottom: 7, top: 7),
        baseColor: Colors.blueGrey[50],
        expandedColor: Colors.blueGrey[50],
        //key: cardA,
        title: Text(
          storedocs[i]['name'],
        ),
        subtitle: const Text(
          "Click to view pilgrim's details",
          style: TextStyle(fontSize: 11),
        ),
        children: [
          const Divider(
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
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Email:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              storedocs[i]['email'],
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Haj ID:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              storedocs[i]['hajId'],
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Pharmaceutical:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              storedocs[i]['pharma'],
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Disease:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              storedocs[i]['disease'],
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            const Text(
                              'Phone:',
                              style: TextStyle(
                                  color: Color(0xFF455D83),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              storedocs[i]['number'],
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]))))
        ])
                                ),
                                ),
                                );
                  },
                  ),
                  ),
        ],
        ),
        ),
      
        );
        
  }
}
