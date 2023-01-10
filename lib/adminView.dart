import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';

//import 'package:rafad1/screens/LoginPage.dart';
class View extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
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
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('Campaign-Account').snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('Campaign-Account').snapshots();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Registration requests'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                //  Navigator.pushNamed(context, LoginPage.screenRoute);
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
                                      child: Image.asset(
                                          "assets/images/kaaba.png"),
                                      backgroundColor: Color(0xFF788AA4),
                                    ),
                                    title: Text(
                                      storedocs[i]['nameCampaign'],
                                    ),
                                    subtitle: Text(
                                      "Click to view campaign's details",
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
                                                    children: [
                                                      Text(
                                                        'Campaign\'s email:  ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]['emailC'],
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
                                                      'Campaign\'s address: ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]['address'],
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
                                                      'Campaign\'s commercial ID:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['commercialID'],
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
                                                      'Campaign\s Phone Number:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['phoneNumberC'],
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
                                                      'Campaign\'s Seating Capacity:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]['capacity'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
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
                                              _firestore
                                                  .collection(
                                                      'AcceptedCampaigns')
                                                  .doc(storedocs[i]['UID'])
                                                  .set({
                                                 //FirebaseAuth
                                                    //.instance.currentUser!.uid,
                                                'UID': storedocs[i]['UID'],
                                                'description':'none',
                                                'status': 'accepted',
                                                'name': storedocs[i]
                                                    ['nameCampaign'],
                                                'emailC': storedocs[i]
                                                    ['emailC'],
                                                'address': storedocs[i]
                                                    ['address'],
                                                'UID': FirebaseFirestore.instance
                                                .collection('userNames')
                                                .where('emailC', isEqualTo: storedocs[i]
                                                    ['emailC'])
                                                .get(),
                                                'commercial_ID': storedocs[i]
                                                    ['commercialID'],
                                                'password': storedocs[i]
                                                    ['password'],
                                                'phoneNumber': storedocs[i]
                                                    ['phoneNumberC'],
                                                'seatingCapacity': storedocs[i]
                                                    ['capacity'],
                                              });

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: StatefulBuilder(
                                                      // You need this, notice the parameters below:
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Accept Request"),
                                                          content: const Text(
                                                              "Are you sure?"),
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
                                                                  setState(
                                                                      () async {
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Campaign-Account')
                                                                        .doc(storedocs[i]
                                                                            [
                                                                            'UID'])
                                                                        .delete();
                                                                  });

                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                        "Yes")),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                              );

                                              /* showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text("Accept Request"),
                                                      content: const Text("Are you sure?"),
                                                      actions: [
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor: Color(0xFF455D83)),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text("Cancel")),
                                                        ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                backgroundColor: Color(0xFF455D83)),
                                                            onPressed: () {
                                                              setState(() {
                                                                storedocs.removeAt(i);
                                                              });

                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text("Yes")),
                                                      ],
                                                    );
                                                  });*/
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                ),
                                                Text('Accept'),
                                              ],
                                            ),
                                          ),
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
                                                          "Reject Request"),
                                                      content: TextField(
                                                        controller: _controller,
                                                        //  errorText: _errorText,
                                                        maxLines: 7,
                                                        onChanged: (value) {
                                                          rejectionReason =
                                                              value;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter reason of rejection",
                                                        ),
                                                      ),
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
                                                            child:
                                                                Text('Cancel')),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30.0)),
                                                            backgroundColor:
                                                                Color(
                                                                    0xFF455D83),
                                                          ), // background
                                                          onPressed: () {
                                                            _firestore
                                                                .collection(
                                                                    'RejectedCampaigns')
                                                                .add({
                                                              'name': storedocs[
                                                                      i][
                                                                  'nameCampaign'],
                                                              'reason':
                                                                  rejectionReason,
                                                              'status':
                                                                  'rejected'
                                                            });
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Submit"),
                                                        )
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Column(
                                              children: <Widget>[
                                                Icon(Icons.cancel_rounded,
                                                    color: Colors.redAccent),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 2.0),
                                                ),
                                                Text('Reject'),
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






/*import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';

import 'package:rafad1/screens/LoginPage.dart';

class View extends StatefulWidget {
  //static const String screenRoute = '_ViewState';
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;
  final fieldText = TextEditingController();
  void clearText() {
    fieldText.clear();
  }

  bool isVisible = true;
  bool _submitted = false;

  void _submit() {
    setState(() => _submitted = true);
    if (_errorText == null) {}
  }

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = fieldText.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code

    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  bool visibilityController = true;
  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('Campaign-Account').snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('Campaign-Account').snapshots();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Registration requests'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, LoginPage.screenRoute);
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
                      a['id'] = document.id;
                    }).toList();
                    return Column(
                        children: List.generate(
                            storedocs.length,
                            (i) => SingleChildScrollView(
                                  child: Visibility(
                                    visible: isVisible,
                                    child: ExpansionTileCard(
                                      elevation: 2,
                                      initialPadding:
                                          EdgeInsets.only(bottom: 7, top: 7),
                                      baseColor: Colors.blueGrey[50],
                                      expandedColor: Colors.blueGrey[50],
                                      //key: cardA,
                                      leading: CircleAvatar(
                                        child: Image.asset(
                                            "assets/images/kaaba.png"),
                                        backgroundColor: Color(0xFF788AA4),
                                      ),
                                      title: Text(
                                        storedocs[i]['nameCampaign'],
                                      ),
                                      subtitle: Text(
                                        "Click to view campaign's details",
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
                                                      children: [
                                                        Text(
                                                          'Campaign\'s email:  ',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF455D83),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          storedocs[i]
                                                              ['emailC'],
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
                                                        'Campaign\'s address: ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]['address'],
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
                                                        'Campaign\'s commercial ID:  ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]
                                                            ['commercialID'],
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
                                                        'Campaign\s Phone Number:  ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]
                                                            ['phoneNumberC'],
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
                                                        'Campaign\'s Seating Capacity:  ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF455D83),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        storedocs[i]
                                                            ['capacity'],
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
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
                                                _firestore
                                                    .collection(
                                                        'AcceptedCampaigns')
                                                    .add({
                                                  'status': 'accepted',
                                                  'name': storedocs[i]
                                                      ['nameCampaign'],
                                                  'email': storedocs[i]
                                                      ['emailC'],
                                                  'address': storedocs[i]
                                                      ['address'],
                                                  'commercialID': storedocs[i]
                                                      ['commercialID'],
                                                  'password': storedocs[i]
                                                      ['password'],
                                                  'phoneNumber': storedocs[i]
                                                      ['phoneNumberC'],
                                                  'seatingCapacity':
                                                      storedocs[i]['capacity'],
                                                });
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Accept Request"),
                                                        content: const Text(
                                                            "Are you sure?"),
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
                                                              },
                                                              child: const Text(
                                                                  "Yes")),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2.0),
                                                  ),
                                                  Text('Accept'),
                                                ],
                                              ),
                                            ),
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
                                                            "Reject Request"),
                                                        content: TextField(
                                                          maxLines: 7,
                                                          onChanged: (value) {
                                                            rejectionReason =
                                                                value;
                                                          },
                                                          controller: fieldText,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Enter reason of rejection",
                                                          ),
                                                        ),
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
                                                              child: Text(
                                                                  'Cancel')),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0)),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF455D83),
                                                            ), // background
                                                            onPressed: () {
                                                              _firestore
                                                                  .collection(
                                                                      'RejectedCampaigns')
                                                                  .add({
                                                                'name': storedocs[
                                                                        i][
                                                                    'nameCampaign'],
                                                                'reason':
                                                                    rejectionReason,
                                                                'status':
                                                                    'rejected'
                                                              });
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Submit"),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(Icons.cancel_rounded,
                                                      color: Colors.redAccent),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2.0),
                                                  ),
                                                  Text('Reject'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )));
                  }))
        ])));
  }
}
*/