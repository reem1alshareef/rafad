import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/navigation/nav_bar.dart';
//import 'package:rafad1/screens/LoginPage.dart';
class DeleteCampaign extends StatefulWidget {
  const DeleteCampaign({super.key});

//static const String screenRoute = 'DeleteCampaign';

  @override
  deleteCampaign createState() => deleteCampaign();
}

class deleteCampaign extends State<DeleteCampaign> {
  final _firestore = FirebaseFirestore.instance;
  //String? rejectionReason;

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

  void DataStreams() async {
    await for (var snapshot
        in _firestore.collection('AcceptedCampaigns').where('status', isEqualTo: 'accepted').snapshots()) {
      for (var campaign in snapshot.docs) {
        print(campaign.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream =
        FirebaseFirestore.instance.collection('AcceptedCampaigns').snapshots();

    return Scaffold(
     // bottomNavigationBar: nav_admin(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Delete Campaign Account'),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, WelcomeScreen.screenRoute);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
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
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 10.0,
                                          ),
                                          child: Center(
                                            child: Column(children: [
                                              Column(children: [
                                                Padding(
                                                  padding:
                                                     EdgeInsets.only(
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
                                                        storedocs[i]['email'],
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
                                                       EdgeInsets.only(
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
                                                          ['commercial_ID'],
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
                                                      'Campaign\'s Phone Number:  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]
                                                          ['phoneNumber'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ]),
                                                ),
                                                Padding(
                                                  padding:
                                                       EdgeInsets.only(
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
                                                      storedocs[i]['seatingCapacity'],
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
                                            style: TextButton.styleFrom(shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)),)),
                                            onPressed: () {
                                              showDialog(
                                                   context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                title: Row(
                                                  children:  [
                                                    Text('Delete '),
                                                    Text(storedocs[i]['name'], style: TextStyle(fontWeight: FontWeight.bold),),
                                                    Text(' account'),
                                                  ],
                                                ),
                                                content: Row(
                                                  children:  [
                                                    Text('Deleting this account '),
                                                    Text('cannot ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                                    Text('be undone, Are you sure you want to delete the account?')
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                                    child:  Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      
                                                      //firebase
                                                      try{
                                                        //await FirebaseFirestore.instance
                                                        //.collection('AcceptedCampaigns').doc(storedocs[i]['UID']).delete();
                                                        //.then((doc) => print("Document deleted"));
                                                        setState(
                                                                  () async {
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'AcceptedCampaigns')
                                                                    .doc(storedocs[i]['UID'])
                                                                    .delete();
                                                                    






                                                                    //start of deleting pilgrims
                                                                    // await for (var snapshot in _firestore.collection('AcceptedCampaigns').doc(storedocs[i]['UID']).collection('pilgrimsRequest').snapshots()); 
                                                                    // final Stream<QuerySnapshot> dataStream =FirebaseFirestore.instance.collection('AcceptedCampaigns').doc(storedocs[i]['UID']).collection('pilgrimsRequest').snapshots();
                                                                    // final List storedocss = [];
                                                                    // snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                    //   Map a = document.data() as Map<String, dynamic>;
                                                                    //   storedocss.add(a);
                                                                    //   a['id'] = document.id;
                                                                    //   }).toList();
                                                                      
                                                                    //   var l;
                                                                    //   List.generate(
                                                                    //     storedocss.length,
                                                                    //     (l) async {
                                                                    //       await FirebaseFirestore.instance
                                                                    // .collection('AcceptedCampaigns')
                                                                    // .doc(storedocs[i]['UID'])
                                                                    // .collection('pilgrimsRequest')
                                                                    // .doc(storedocss[l]['UID'])
                                                                    // .delete();
                                                                    //     }
                                                                    //     );
                                                                    //end of deleting pilgrims









                                                                    // await FirebaseFirestore
                                                                    // .instance
                                                                    // .collection(
                                                                    //     'AcceptedCampaigns')
                                                                    // .doc(storedocs[i]['UID'])
                                                                    // .collection('pilgrimsRequest')
                                                                    // .batch.delete();
                                                              });
                                                        Navigator.pop(context, 'Delete');
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const AlertDialog(
                                                              content: 
                                                              Text('Account been deleted succesfully', style: TextStyle(color: Colors.green),),
                                                              );
                                                              });
                                                        
                                                      } catch(e){
                                                        //e.hashCode;
                                                        //print(e.runtimeType);
                                                        
                                                        Navigator.pop(context, 'Delete');
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return const AlertDialog(
                                                              content: 
                                                              Text('Account been deleted succesfully', style: TextStyle(color: Colors.green),),
                                                              );
                                                              });

                                                        
                                                        // showDialog(
                                                        //   context: context,
                                                        //   builder: (context) {
                                                        //    //var m=e.message;
                                                        //     return const AlertDialog(
                                                        //       content:
                                                        //       Text('Account could not be deleted, try again.' , style: TextStyle(color: Colors.red,)));
                                                        //       //print(m);
                                                        //       });
                                                      }
                                                    },//=> Navigator.pop(context, 'OK'),
                                                    child: Text('Delete'),
                                                  ),
                                                ],
                                              );
                                              }
                                              );
                                              
                                            },



                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.cancel_rounded, color: Colors.redAccent),
                                                Padding(padding: EdgeInsets.symmetric(vertical: 2.0),),
                                                Text(' Delete account'),
                                              ],
                                            ),



                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )));
                  }))
        ]
        )
        )
        );
  }
}
