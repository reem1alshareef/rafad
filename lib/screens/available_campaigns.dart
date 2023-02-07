//هذي اول بيج تطلع للحاج اذا سوا لوق ان
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:rafad1/search/search_campaign.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

//import '../search/campaign_design_widget.dart';
import '../search/user1.dart';
import '../view_rate_review/campaign_view_rate.dart';
import '../widgets/my_button.dart';
import 'availableCampaignsWidget.dart';

//import 'package:rafad1/screens/LoginPage.dart';
class availableCampaigns extends StatefulWidget {
//static const String screenRoute = 'logOutPilgrim.dart';
const availableCampaigns({super.key});

  @override
  _availableCampaignsState createState() => _availableCampaignsState();
}

class _availableCampaignsState extends State<availableCampaigns> {
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
        .where('status', isEqualTo: 'accepted')
        .snapshots();
        
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Available campaigns'),
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
                      SearchCampaign()));
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
                                    initialPadding:
                                        EdgeInsets.only(bottom: 7, top: 7),
                                    baseColor: Colors.blueGrey[50],
                                    expandedColor: Colors.blueGrey[50],
                                    //key: cardA,
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                          "assests/images/campaignLogo.png"),
                                      backgroundColor: Color(0xFF788AA4),
                                    ),
                                    title: Text(
                                      storedocs[i]['name'],//storedocs[i]['UID']
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
                                                      'Campaign\s Phone Number:  ',
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
                                                      storedocs[i]['seatingCapacity'],
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ]),
                                                ),
                                                 Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Column(children: [
                                                    Text(
                                                      'Campaign\'s description :  ',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF455D83),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      storedocs[i]['description'],
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
                                      RatingStars(
                                                
                                                  rating: double.parse(storedocs[i]['avrgRating']), 
                                                  editable: false,
                                                  color: Colors.amber,
                                                  iconSize: 20,
                                                  ),
                                                GestureDetector(
                                                    onTap: () => {
                                                        Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                        builder: (context) =>
                                                      ratingsList( campaignId: storedocs[i]['UID'] , averageShopRating: double.parse(storedocs[i]['avrgRating']),  numberOfRatings: double.parse(storedocs[i]['numberOfPeople']))))
                                },
                                child: Text(
                                   storedocs[i]['numberOfPeople'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                                                  ),             
                                                  /*MyButton(color: Color(0xFF455D83), title: 'View Rates', onPressed: ()async {

                DocumentSnapshot variable = await FirebaseFirestore.instance
                                    .collection('AcceptedCampaigns')
                                    .doc(storedocs[i]['UID'])
                                    .get();

                                    String thisCampaignId = variable['UID'];
                                    double thisAvrgRating = double.parse(variable['avrgRating']);
                                    double thisNumberOfPeople = double.parse(variable['numberOfPeople']);
                Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  ratingsList( campaignId: thisCampaignId, averageShopRating: thisAvrgRating,  numberOfRatings: thisNumberOfPeople )));
              ;}
              ),*/
                                      /////////////////buton
                                      const SizedBox(height: 10,),

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
