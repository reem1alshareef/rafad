import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/navigation/nav_bar.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:rafad1/screens/PiligrimProfile.dart';
import 'package:rafad1/screens/ProfileCampaign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class edit_Pilgrim extends StatefulWidget {
  static const String screenRoute = 'signUP_pilgrim';
  const edit_Pilgrim({Key? key}) : super(key: key);

  @override
  State<edit_Pilgrim> createState() => _edit_PilgrimState();
}

class _edit_PilgrimState extends State<edit_Pilgrim> {
  String? name;
  String? email;
  String? number;
  String? hajId;
  String? disease;
  String? pharma;
  //String? password;
   @override
  void initState() {
    getData();

    super.initState();
  }


 Map<String, dynamic> map = {};

  void getData() async {
    await FirebaseFirestore.instance
        .collection('Pilgrims-Account')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        map = value.data()!;
      });
      print(map["name"]);

      print('00000000000000000000000000000000000000000000000000');
    }).catchError((onError) {
      print(onError);
      print('999999999999999999999999999999999999999999999999999');
    });
  }

  final _signupFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var razan = 'roz';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(map['name']+' Profile'),
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
                          title: 'Edit Profile',
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
                              name = value;
                            });
                          },
                          initialValue: map['name'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name field is required!';
                            } else if (value.length < 8) {
                              return 'Please enter valid name';
                            }

                            String patttern =
                                (r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                            RegExp regExp = RegExp(patttern);
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter valid name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Pilgrim Name *',
                            hintText: 'Your full name',
                            isDense: true,
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
                          initialValue: map['email'],// intiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Email is required!';
                            }
                            if (!EmailValidator.validate(textValue)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email *',
                            hintText: 'Your email id',
                            isDense: true,
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
                              number = value;
                            });
                          },
                          initialValue: map['number'],//intiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required!';
                            }
                            String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(patttern);
                            if (!regExp.hasMatch(value)) {
                              return 'Please enter valid Phone number';
                            }
                            if (value.length != 10) {
                              return 'Phone Number must be of 10 digit';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Phone number *',
                            hintText: 'Your phone number',
                            isDense: true,
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
                              hajId = value;
                            });
                          },
                          initialValue: map['hajId'],// intiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
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
                            labelText: 'haj permission ID*',
                            hintText: 'your haj permission ID',
                            isDense: true,
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
                              disease = value;
                            });
                          },
                          initialValue: map['disease'],//initiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'please enter none if there isn\'t any!';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'chronic disease',
                            hintText: 'if you suffer from any chronic disease',
                            isDense: true,
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
                              pharma = value;
                            });
                          },
                          initialValue: map['pharma'],//intiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'please enter none if there isn\'t any!';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'pharmaceutical',
                            hintText: 'if you are taking any pharmaceutical',
                            isDense: true,
                          ),
                        ),

                        const SizedBox(
                          height: 16,
                        ), //-------------------------------------------------------------------------------
                        CustomFormButton(
                          innerText: 'Save',
                          onPressed: () async {
                            if (_signupFormKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Submitting data..')),
                              );
                              //  Firebase method creating user account
                             //Navigator.pushNamed(context, PiligrimProfile.screenRoute);
                              Navigator.pop(context);

                              

                              // Firestore method -- assign a sub dir from Campaign-Account doc for the current user
                              if (name != null) {
                                await FirebaseFirestore.instance
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'name': name,
                                });
                              }
                              if (email != null) {
                                await FirebaseFirestore.instance
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'email': email,
                                });
                              }

                              if (number != null) {
                                await FirebaseFirestore.instance
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'number': number,
                                });
                              }

                              if (hajId != null) {
                                await FirebaseFirestore.instance
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'hajId': hajId,
                                });
                              }
                              if (disease != null) {
                                await FirebaseFirestore.instance
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'disease': disease,
                                });
                              }

                              if (pharma != null) {
                                await FirebaseFirestore.instance
                                    .collection("Pilgrims-Account")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'pharma': pharma,
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
