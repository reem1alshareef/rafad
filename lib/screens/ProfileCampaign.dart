import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:rafad1/screens/campaignRealMap.dart';
import 'package:rafad1/widgets/my_button.dart';

import '../view_rate_review/campaign_view_rate.dart';

// from here the 5try

class ProfileCampaign extends StatefulWidget {
  static const String screenRoute = 'ProfileCampaign.dart';
  const ProfileCampaign({super.key});

  @override
  _ProfileCampaignState createState() => _ProfileCampaignState();
}

class _ProfileCampaignState extends State<ProfileCampaign> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }
  /*final _firestore = FirebaseFirestore.instance;

  final _controller = TextEditingController();
  late final double _latitude;
  late final double _longitude;*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, WelcomeScreen.screenRoute);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text("campaign profile"),
        backgroundColor:  Color.fromARGB(255, 12, 92, 119),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                _getLocation();
              },
              child: const Text(
                'Add my location',
                style: TextStyle(
                    color: Color(0xFF455D83), fontWeight: FontWeight.w500),
              )),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                _listenLocation();
              },
              child: const Text(
                'Enable live location',
                style: TextStyle(
                    color: Color(0xFF455D83), fontWeight: FontWeight.w500),
              )),
          const SizedBox(
            height: 16,
          ),
          TextButton(
              onPressed: () {
                _stopListening();
              },
              child: const Text(
                'Stop live location',
                style: TextStyle(
                    color: Color(0xFF455D83), fontWeight: FontWeight.w500),
              )),

              MyButton(color: Color(0xFF455D83), title: 'View Rate', onPressed: ()async {

                DocumentSnapshot variable = await FirebaseFirestore.instance
                                    .collection('AcceptedCampaigns')
                                    .doc(FirebaseAuth.instance.currentUser?.uid)
                                    .get();

                                    String thisCampaignId = variable['UID'];
                                    double thisAvrgRating = double.parse(variable['avrgRating']);
                                    double thisNumberOfPeople = double.parse(variable['numberOfPeople']);
                Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  ratingsList( campaignId: thisCampaignId, averageShopRating: thisAvrgRating,  numberOfRatings: thisNumberOfPeople )));
              ;}
              )
          /*  Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('AcceptedCampaigns')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(snapshot.data!.docs[index]['name'].toString()),
                      subtitle: Row(
                        children: [
                          Text(snapshot.data!.docs[index]['latitude']
                              .toString()),
                          SizedBox(
                            width: 20,
                          ),
                          Text(snapshot.data!.docs[index]['longitude']
                              .toString()),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          //هذا المكان اللي اذا ضغط عليه يوديه للموقع
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => campaignRealMap(
                                  snapshot.data!.docs[index].id)));
                        },
                      ),
                    );
                  });
            },
          )),*/
        ],
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData _locationResult = await location.getLocation();
      await FirebaseFirestore.instance
          .collection('AcceptedCampaigns')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        //'name': 'john'
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance
          .collection('AcceptedCampaigns')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        // 'name': 'john'
      }, SetOptions(merge: true));
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
} // end of class

/* child: Column(
          children: [
            MyButton(
              color: Color.fromARGB(55, 4, 66, 55),
              title: 'click here to udpate your Location',
              onPressed: () async {
//////////////////////////الكود اللي بيرسل اللوكيشن الحالي لليوزر

                LocationService _LocationService = LocationService();
                _LocationService.CampsendLocationToDataBase(context);

///////////////////////////////
              },
            ),
            MyButton(
              color: Color.fromARGB(55, 4, 66, 55),
              title: 'click here to udpate your Location',
              onPressed: () async {
//////////////////////////هذا اللي يعرض الماب الحين يابتول حطيته عشان تجربين الخريطة تطلع ولا لا

                LocationService _locationService = LocationService();
                _locationService.goToMaps(24.7231819, 46.6367413);

///////////////////////////////
              },
            ),
          ],
        ),
          ),*/