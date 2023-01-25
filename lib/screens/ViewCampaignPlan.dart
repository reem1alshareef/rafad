import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ViewCampaignPlan extends StatefulWidget {
  //static const String screenRoute = 'welcome_screen';
  const ViewCampaignPlan({super.key});
  @override
  _ViewState createState() => _ViewState();
  String ID;

  Future<void> start() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
          .collection('Pilgrims-Account')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      ID = variable["ChosenCampaignID"];
      print(ID);
   // }

   //getID();
    //}

    print(ID);
    Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("AcceptedCampaigns")
        .doc(ID)
        .collection("Activities")
        .snapshots();
    print(ID);
  }
}

class _ViewState extends State<ViewCampaignPlan> {
  @override
  Future<Widget> build(BuildContext context) async {
    String ID = 'blah';

    

    print(ID);
    Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("AcceptedCampaigns")
        .doc(ID)
        .collection("Activities")
        .snapshots();
    print(ID);

    return Scaffold(
      DocumentSnapshot variable = await FirebaseFirestore.instance
          .collection('Pilgrims-Account')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();
      ID = variable["ChosenCampaignID"];
      print(ID);
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Today\'s Campaign plan'),
          backgroundColor: const Color(0xFF455D83),
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
                        child: Container(
                          margin: EdgeInsets.only(bottom: 17),
                          child: ListTile(
                            title: Text(
                              storedocs[i]['title'],
                              style: TextStyle(
                                  color: Color(0xFF455D83), fontSize: 20),
                            ),
                            trailing:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                ' Starts at  '
                                ' ${storedocs[i]['time'].toDate().hour} : ${storedocs[i]['time'].toDate().minute} ',
                                style: TextStyle(
                                    color: Color(0xFF455D83),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Icon(Icons.access_time_rounded)
                            ]),
                            tileColor: Color.fromARGB(255, 228, 232, 235),
                            contentPadding: EdgeInsets.all(17),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ])));
  }
}