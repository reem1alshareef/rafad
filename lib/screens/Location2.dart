import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quaratrack_01/models/user_model.dart';
import 'package:geolocator/geolocator.dart';

const kDefaultPadding = 20.0;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
   var locationMessage = '';

  late String latitude;
  late String longitude;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });}

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(appBar: AppBar(
            backgroundColor: Colors.cyan[50],
            leading: IconButton(
              icon: Icon(Icons.menu),
              iconSize: 35,
              color: Colors.black,
              onPressed: () {},
            ),
        title: const Text("Profile"),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        centerTitle: true),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: kDefaultPadding / 2,
              left: kDefaultPadding / 3,
              right: kDefaultPadding / 3,
              bottom: kDefaultPadding / 3,
            ),
            child: Column(
              children: [
                Form(
                    child: Column(
                      children: [
                        buildNameField(),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        buildICField(),
                        SizedBox(height: kDefaultPadding,
                        ),
                        buildPhoneField(),
                        SizedBox(
                        height: kDefaultPadding,
                        ),
                        buildEmailField(),
                        SizedBox(height: kDefaultPadding,
                        ),
                        buildLocationField(),
                        SizedBox(height: kDefaultPadding * 1.5,
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.blueAccent,
                          child:MaterialButton(
                          padding: EdgeInsets.fromLTRB(20, 17, 20, 17),
                          minWidth: 100,
                          onPressed: () {getCurrentLocation();},
                          child: Text(
                          "CONFIRM ADDRESS", 
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        ),
                  )
                      ])
                )],
                    )),
            ),
          ),
        );
        }

TextFormField buildNameField() {
    return TextFormField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Name:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        hintText: "${loggedInUser.firstName} ${loggedInUser.secondName}",
        hintStyle: TextStyle(color: Colors.black, fontSize: 20),
        enabled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: Icon(Icons.account_circle, color: Colors.blue, size: 35),
        ),
      );
    }

    TextFormField buildICField() {
    return TextFormField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'IC/Passport No:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        hintText: '12345678',
        hintStyle: TextStyle(color: Colors.black, fontSize: 20),
        enabled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: Icon(Icons.perm_identity, color: Colors.blue, size: 35),
        ),
      );
    }

    TextFormField buildPhoneField() {
    return TextFormField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Phone Number:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        hintText: '0123456789',
        hintStyle: TextStyle(color: Colors.black, fontSize: 20),
        enabled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: Icon(Icons.call_rounded, color: Colors.blue, size: 35),
        ),
      );
    }

    TextFormField buildEmailField() {
    return TextFormField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email Address:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        hintText: "${loggedInUser.email}",
        hintStyle: TextStyle(color: Colors.black, fontSize: 20),
        enabled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: Icon(Icons.mail, color: Colors.blue, size: 35),
        ),
      );
    }

    TextFormField buildLocationField() {
    return TextFormField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Quarantine Location:',
        labelStyle: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        hintText: locationMessage,
        hintStyle: TextStyle(color: Colors.red, fontSize: 20),
        enabled: false,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        icon: Icon(Icons.location_city, color: Colors.blue, size: 35),
        ),
      );
    }
    void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    //passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Lat: $lat, Long: $long";
    });
  }}

//Appreciate if someone can help! Please!