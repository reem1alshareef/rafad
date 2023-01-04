import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:rafad1/screens/logOutCampaign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toast/toast.dart';

class SignUpCampaign extends StatefulWidget {
  static const String screenRoute = 'signUp_campaign';
  const SignUpCampaign({Key? key}) : super(key: key);

  State<SignUpCampaign> createState() => _SignUpCampaignState();
}

@override
class _SignUpCampaignState extends State<SignUpCampaign> {
  String? nameCampaign;
  String? emailC;
  String? phoneNumberC;
  String? commercialID;
  String? address;
  String? capacity;
  String? password;
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("sign up as campaign"),
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
                const PageHeader(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assests/images/background.png"),
                        fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const PageHeading(
                          title: 'Registration request',
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
                              nameCampaign = value;
                            });
                          },
                          validator: (textValue) { 
                            if (textValue == null || textValue.isEmpty) {
                              return 'Name field is required!';
                            }

                            if (!RegExp(r'^[a-z A-Z]+$').hasMatch(textValue)) {
                              //allow upper and lower case alphabets and space
                              return "Please enter valid name";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Campaign Name *',
                            hintText: 'your campaign name',
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
                              emailC = value;
                            });
                          },
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
                              phoneNumberC = value;
                            });
                          },
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
                              commercialID = value;
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
                            labelText: 'commercial registraion ID *',
                            hintText: 'your commercial registraion ID',
                            isDense: true,
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
                            labelText: 'address *',
                            hintText: 'your campaign address',
                            isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              capacity = value;
                            });
                          },
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'number of campaign capacity is required!';
                            }
                            String patttern =
                                (r'^\d+\.?\d{0,1}'); //يكون بس ارقام
                            RegExp regExp = new RegExp(patttern);
                            if (!regExp.hasMatch(textValue)) {
                              return 'Please enter valid capacity number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Seating capacity *',
                            hintText: 'The number of campaign capacity',
                            isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          obscureText: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            if (!textValue.contains(RegExp(r'[0-9]'))) {
                              return "Password must contain a digit";
                            }
                            if (!textValue.contains(RegExp(r'[A-Z]'))) {
                              return "Password must contain at least one upper case";
                            }
                            if (!textValue.contains(RegExp(r'[a-z]'))) {
                              return "Password must contain at least one lower case";
                            }
                            if (textValue.length < 6) {
                              return "Password must be at least 6 characters in length";
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password *',
                            hintText: 'Your password',
                            isDense: true,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        //-------------------------------------------------------------------------------
                        CustomFormButton(
                          innerText: 'Sign up',
                          onPressed: () async {
                            if (_signupFormKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Submitting data..')),
                              );
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailC.toString(),
                                      password: password.toString())
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Registeration request been sent to the admin, you will receive an email soon with the statusof your request.'),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.pushNamed(
                                    context, logOutCampaign.screenRoute);
                              }).catchError((onError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$onError'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              });

                              await FirebaseFirestore.instance
                                  .collection("Campaign-Account")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set({
                                'nameCampaign': nameCampaign,
                                'emailC': emailC,
                                'UID': FirebaseAuth.instance.currentUser!.uid,
                                'phoneNumberC': phoneNumberC,
                                'commercialID': commercialID,
                                'address': address,
                                'capacity': capacity,
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account ? ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff939393),
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()))
                                },
                                child: const Text(
                                  'Log-in',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
