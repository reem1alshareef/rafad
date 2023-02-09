import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/navigation/nav_bar.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:rafad1/screens/PiligrimProfile.dart';

import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';

class edit_p extends StatefulWidget {
  static const String screenRoute = 'edit_p';
  const edit_p({Key? key}) : super(key: key);

 
  State<edit_p> createState() => _edit_pState();
}

@override
class _edit_pState extends State<edit_p> {
  String? name  ;
  String? hajId;
  String? number;
  String? email;
  String? disease;
  String? pharma;
  final _signupFormKey = GlobalKey<FormState>();
 
 
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

  @override
  Widget build(BuildContext context) {
    var razan = "name" ;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(map["name"]),
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
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        //controller: razan,
                         initialValue: razan,
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
                              hajId = value;
                            });
                          },
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
                            hintText: 'ID ',
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
                              number = value;
                            });
                          },
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
                              disease = value;
                            });
                          },
                          validator: (textValue) {
                            //يقبل من3 بشرط يكون فيها حرف عالاقل +رقم
                            if (textValue == null || textValue.isEmpty) {
                              return ' is required!';
                            }
                            

                            return null;
                          },
                          decoration: InputDecoration(
                       //     labelText: 'address *',
                            hintText: 'dises',
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
                              pharma = value;
                            });
                          },
                          
                          decoration: InputDecoration(
                           // labelText: 'Campaign Name ',
                            hintText: 'pharm',
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
                                            const PiligrimProfile()));
                              // 
                              // Firestore method -- assign a sub dir from Campaign-Account doc for the current user
                              await FirebaseFirestore.instance
                                  .collection("Pilgrims-Account")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'name': name,
                                'hajId': hajId,
                                'number': number,
                                'emailC': email,
                                //'UID': FirebaseAuth.instance.currentUser!.uid,
                              
                                'disease': disease,
                                'pharma': pharma,
                                //'capacity': capacity,
                              });
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