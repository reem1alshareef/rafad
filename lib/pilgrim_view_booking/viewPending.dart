import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/Chat_screen.dart';
import 'package:rafad1/screens/welcome_screen.dart';

//import 'package:rafad1/screens/LoginPage.dart';
class viewPending extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';
  const viewPending({super.key});
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<viewPending> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;

  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool card = false;
  bool isVisible = true;
  bool _submitted = false;

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

  //data streeeeeeeeeeeeeemmmms

  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('AcceptedCampaigns').snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Pilgrims-Account")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("pilgrimCampaigns")
        .where('bookStatus', isEqualTo: 'pending')
        .snapshots();

/*
  void DataStreams() async {
    FirebaseFirestore.instance.collection ("AcceptedCampaigns").get().then((value) {
value.docs. forEach ((result) {

FirebaseFirestore.instance.collection ("AcceptedCampaigns")
.doc (result.id)
.collection ("pilgrimsRequest")
.get()
. then ((subcol) {
subcol.docs .forEach ((element) {
print (element. data());
});

    });
     } );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('AcceptedCampaigns').snapshots();

FirebaseFirestore.instance.collection ("users") .get () . then((value) {
value. docs. forEach ((result) {
FirebaseFirestore.instance.collection ("users")
.doc (result.1d)
.collection ("pets")
.get()
. then ((subcol) {
subcol.docs .forEach ((element) {
print (element. data());l
});
]);*/
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

        /*appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Booking Requests'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              },
            )
          ],
        ),*/
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
                                      "Click to view requests's details",
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
                                                  child: Column(
                                                    children: const [
                                                      Text(
                                                        'your Request has been submitted  successfully !',
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    200,
                                                                    20,
                                                                    20),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                                      'Request Status: ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['bookStatus'],
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromARGB(
                                                            255, 109, 94, 19),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ]),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceAround,
                                        buttonHeight: 52.0,
                                        buttonMinWidth: 90.0,
                                        children: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.0)),
                                            )),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Cancel Request"),
                                                      content: const Text(
                                                          "Are you sure you want to Cancel?"),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF455D83)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Cancel")),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFF455D83)),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(
                                                                  () async {
                                                                // حذف البيانات الخاصه باليوزر من الفايرستور
                                                                var cID =
                                                                    storedocs[i]
                                                                        [
                                                                        'campaignID'];
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "Pilgrims-Account")
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser
                                                                        ?.uid)
                                                                    .collection(
                                                                        "pilgrimCampaigns")
                                                                    .doc(FirebaseAuth
                                                                        .instance
                                                                        .currentUser
                                                                        ?.uid)
                                                                    .delete();
                                                              });
                                                            },
                                                            child: const Text(
                                                                "Yes")),
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Column(
                                              children: const <Widget>[
                                                Icon(Icons.cancel_rounded,
                                                    color: Colors.redAccent),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.0),
                                                ),
                                                Text('Cancel'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )));
                  }))
        ])));
  }
}
