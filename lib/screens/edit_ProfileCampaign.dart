import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/navigation/nav_bar.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:rafad1/screens/ProfileCampaign.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';

class edit_Campaign extends StatefulWidget {
  static const String screenRoute = 'edit_Campaign';
  const edit_Campaign({Key? key}) : super(key: key);

  State<edit_Campaign> createState() => _edit_CampaignState();
}

@override
class _edit_CampaignState extends State<edit_Campaign> {
  String? name  ;
  String? commercial_ID;
  String? phoneNumber;
  String? email;
  String? address;
  String? description;
  final _signupFormKey = GlobalKey<FormState>();
 
 
  @override
  void initState() {
    getData();

    super.initState();
  }


 Map<String, dynamic> map = {};

  void getData() async {
    await FirebaseFirestore.instance
        .collection('AcceptedCampaigns')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        map = value.data()!;
      });
      print(map["email"]);

      print('00000000000000000000000000000000000000000000000000');
    }).catchError((onError) {
      print(onError);
      print('999999999999999999999999999999999999999999999999999');
    });
  }

  @override
  Widget build(BuildContext context) {
    String? cname = map['name'];
    var razan = 'roz';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ), //عشان سهم رجوع

        backgroundColor: const Color(0xffEEF1F3),
        body: SingleChildScrollView(
          //للسكرولنق ممتاز
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: [
              //  const PageHeader(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                 
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const PageHeading(
                          title: 'edit your Profile',
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z- -]"))
                          ],

                           initialValue: map['email'].toString(),
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        //controller: razan,

                         //initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {

                             if (!RegExp(r'^[a-z A-Z]+$').hasMatch(textValue!)) {
                              //allow upper and lower case alphabets and space
                              return "Please enter valid name";
                            }

                          

                           
                            return null;
                          },
                          decoration: InputDecoration(
                           
                           
                            //hintText: 'name',
                          
                           // isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),



                        TextFormField(
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              commercial_ID = value;
                            });
                          },

                          initialValue: '4352555252', //initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {

                            
                            if (textValue == null || textValue.isEmpty) {
                              return 'ID is required!';
                            }
                            if (!textValue.contains(RegExp(r'[0-9]'))) {
                              return 'Please enter valid ID';
                            }
                            if (textValue.length != 10) {
                              return 'ID must be of 10 digit';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'commercial ID ',
                           //helperText: 'commercial registraion ID ',
                           // hintText: 'your commercial registraion ID',
                           // isDense: true,
                          
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        TextFormField(
                          maxLength: 10,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },

                           initialValue: '0545058120',  //initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (value) {
                            
                            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(patttern);
                            if (!regExp.hasMatch(value!)) {
                              return 'Please enter valid Phone number';
                            }
                            if (value.length != 10) {
                              return 'Phone Number must be of 10 digit';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                           // labelText: 'Phone number ',
                            hintText: 'Your phone number',
                           // isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),


                        TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },


                          initialValue: 'reem@camp.com',  //initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {
                           
                            if (!EmailValidator.validate(textValue!)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                        //    labelText: 'Email ',
                            hintText: 'Your email',
                           // isDense: true,
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ),

                        

                        TextFormField(
                          maxLength: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z-0-1-2-3-4-5-6-7-8-9]"))
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              address = value;
                            });
                          },

                          initialValue: 'B60', //initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {
                            //يقبل من3 بشرط يكون فيها حرف عالاقل +رقم
                            if (textValue == null || textValue.isEmpty) {
                              return 'Address is required!';
                            }
                            if (!textValue.contains(RegExp(r'[0-9]'))) {
                              return "Please enter valid address, Ex:B02";
                            }
                            if (!textValue.contains(RegExp(r'[A-Za-z]'))) {
                              return "Please enter valid address, Ex:B02";
                            }

                            if (textValue.length != 3) {
                              return 'Address must be of 3 characters in length at least';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                       //     labelText: 'address *',
                            hintText: 'campaign address',
                           // isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z- -]"))
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          initialValue: 'we are a nice Campagin and privide the best services',  //initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          decoration: InputDecoration(
                           // labelText: 'Campaign Name ',
                            hintText: 'descrition',
                           // isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                       
                        //-------------------------------------------------------------------------------
                        CustomFormButton(
                          innerText: 'Save',
                          onPressed: () async {
                            if (_signupFormKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Submitting data..')),
                              );
                              //  Firebase method creating user account
                              
                               
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileCampaign()));
                              // 
                              // Firestore method -- assign a sub dir from Campaign-Account doc for the current user



                                 if(name != null){
                              await FirebaseFirestore.instance
                                  .collection("AcceptedCampaigns")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({

                                 'name': name,
                               
                              });

                            }

                               if(commercial_ID != null){
                              await FirebaseFirestore.instance
                                  .collection("AcceptedCampaigns")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({

                               'commercial_ID': commercial_ID,
                               
                              });

                            }


                              if(phoneNumber != null){
                              await FirebaseFirestore.instance
                                  .collection("AcceptedCampaigns")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({

                                'phoneNumber': phoneNumber,
                               
                                //'capacity': capacity, 
                               
                              });
                            }

                            if(email != null){
                              await FirebaseFirestore.instance
                                  .collection("AcceptedCampaigns")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({

                               
                                'email': email,
                                //'UID': FirebaseAuth.instance.currentUser!.uid,
                              
                                //'capacity': capacity, 
                               
                              });

                            }

                            if(address != null){
                              await FirebaseFirestore.instance
                                  .collection("AcceptedCampaigns")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({

                                //'UID': FirebaseAuth.instance.currentUser!.uid,
                              
                                'address': address,
                           
                                //'capacity': capacity, 
                               
                              });

                            }

                            if(description != null){
                              await FirebaseFirestore.instance
                                  .collection("AcceptedCampaigns")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({

                                
                                'description': description,
                                //'capacity': capacity, 
                               
                              });

                            }




                            
                            }
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Image.asset('assests/images/logo.png'),
    );
  }
}

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'NotoSerif'),
      ),
    );
  }

}