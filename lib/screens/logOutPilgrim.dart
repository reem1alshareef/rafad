//هذي اول بيج تطلع للحاج اذا سوا لوق ان
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';

import '../widgets/my_button.dart';

//import 'package:rafad1/screens/LoginPage.dart';
class logOutPilgrim extends StatefulWidget {
  static const String screenRoute = 'logOutPilgrim.dart';
  const logOutPilgrim({super.key});
/*@override
  State<logOutPilgrim> createState() => _logOutPilgrim();
}

class _logOutPilgrimState extends State<logOutPilgrim> {
  final _firestore = FirebaseFirestore.instance;
  String? rejectionReason;
  bool isButtonActive = true;////// حق شرط البوتون انه مايسمح للحاج يضغط اكثر من مره
  final _controller = TextEditingController();
  
  User? user;

*/

  @override
  _logOutPilgrimState createState() => _logOutPilgrimState();
}

class _logOutPilgrimState extends State<logOutPilgrim> {
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
  //var bookList=new List();

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
        in _firestore.collection('AcceptedCampaigns').snapshots()) {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('available campaign for booking'),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                //margin: EdgeInsets.all(60),
                color: Color.fromARGB(255, 179, 181, 183),

                // child: Padding(
                //   padding: const EdgeInsets.all(17),
                //   // child: Text(
                //   //   'available campaign',
                //   //   style: TextStyle(
                //   //     fontSize: 50,
                //   //     fontWeight: FontWeight.w900,
                //   //     fontStyle: FontStyle.normal,
                //   //     color: Color(0xFF455D83),
                //   //   ),
                //   // ),
                // ),
              ),
            ),
            Container(
              //كود الخلفيه
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assests/images/background.png"),
                    fit: BoxFit.cover),
              ),
            ), //كود الخلفيه لين هنا بس ما اشتغلت

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
                          initialPadding: EdgeInsets.only(bottom: 7, top: 7),
                          baseColor: Colors.blueGrey[50],
                          expandedColor: Colors.blueGrey[50],
                          //key: cardA,
                          leading: CircleAvatar(
                            child:
                                Image.asset("assests/images/campaignLogo.png"),
                            backgroundColor: Color(0xFF788AA4),
                          ),
                          title: Text(
                            storedocs[i]['name'], //storedocs[i]['UID']
                            //                                   _firestore.collection("acceptedCampaigns")
                            // .doc(storedocs[i]['UID'])
                            // .collection("pilgrimsRequest").add
                            //
                            // .doc(pilgrim ID);
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
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Campaign\'s email:  ',
                                              style: TextStyle(
                                                  color: Color(0xFF455D83),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              storedocs[i]['email'],
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(children: [
                                          Text(
                                            'Campaign\'s address: ',
                                            style: TextStyle(
                                                color: Color(0xFF455D83),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            storedocs[i]['address'],
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(children: [
                                          Text(
                                            'Campaign\'s commercial ID:  ',
                                            style: TextStyle(
                                                color: Color(0xFF455D83),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            storedocs[i]['commercial_ID'],
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(children: [
                                          Text(
                                            'Campaign\s Phone Number:  ',
                                            style: TextStyle(
                                                color: Color(0xFF455D83),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            storedocs[i]['phoneNumber'],
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(children: [
                                          Text(
                                            'Campaign\'s Seating Capacity:  ',
                                            style: TextStyle(
                                                color: Color(0xFF455D83),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            storedocs[i]['seatingCapacity'],
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ]),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(children: [
                                          Text(
                                            'Campaign\'s description :  ',
                                            style: TextStyle(
                                                color: Color(0xFF455D83),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            storedocs[i]['description'],
                                            style: TextStyle(fontSize: 12),
                                          )
                                        ]),
                                      ),
                                    ]),
                                  ]),
                                ),
                              ),
                            ),
                            /////////////////buton

                            MyButton(
                              color: const Color(0xFF455D83),
                              title: 'book',
                              onPressed: () async {
                                int counter =
                                    int.parse(storedocs[i]['seatingCapacity']) -
                                        1;

                                FirebaseFirestore.instance
                                    .collection('AcceptedCampaigns')
                                    .doc(storedocs[i]['UID'])
                                    .update({
                                  'seatingCapacity': counter.toString(),
                                });
                                _firestore
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .collection("pilgrimCampaigns")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .set(
                                  {
                                    'bookStatus': 'pending',
                                    'campaignID': storedocs[i]['UID'],
                                    'name': storedocs[i]['name'],
                                  },
                                );

                                DocumentSnapshot variable = await _firestore
                                    .collection('Pilgrims-Account')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();
                                String name = variable['name'];
                                String email = variable['email'];
                                String number = variable['number'];
                                String disease = variable['disease'];
                                String hajId = variable['hajId'];
                                String pharma = variable['pharma'];

                                _firestore
                                    .collection("AcceptedCampaigns")
                                    .doc(storedocs[i]['UID'])
                                    .collection("pilgrimsRequest")
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .set(
                                  {
                                    'bookStatus': 'pending',
                                    'pilgrimID':
                                        FirebaseAuth.instance.currentUser?.uid,
                                    'name': name,
                                    'number': number,
                                    'email': email,
                                    'disease': disease,
                                    'hajId': hajId,
                                    'pharma': pharma
                                  },
                                );
                              },
                            ) ////////////////buton
                          ],
                        ),
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