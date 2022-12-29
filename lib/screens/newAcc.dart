import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/signUp_campaign.dart';

class NewAcc extends StatefulWidget {
  static const String screenRoute = 'newAcc';
  const NewAcc({Key? key}) : super(key: key);

  @override
  State<NewAcc> createState() => _NewAccState();
}

class _NewAccState extends State<NewAcc> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 100,
                    height: 100,
                    child: Image.asset('assests/images/logo.png')),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      email = value;
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
                SizedBox(height: 20),
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
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return '';
                    } else if (val != password) {
                      return '';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, SignUpCampaign.screenRoute);
                      if (formKey.currentState!.validate()) {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email.toString(),
                                password: password.toString())
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Registeration request been sent to the admin, you will receive an email soon with the statusof your request.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }).catchError((onError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$onError'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });
                      }
                    },
                    child: Text('Sign Up'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
