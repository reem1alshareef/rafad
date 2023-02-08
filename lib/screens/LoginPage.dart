import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/navigation/nav_bar.dart';
import 'package:rafad1/screens/LoginPage.dart';
import 'package:rafad1/screens/available_campaigns.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/screens/forget_pw.dart';
import 'package:toast/toast.dart';
import 'package:rafad1/screens/welcome_screen.dart';

class LoginPage extends StatefulWidget {
  static const String screenRoute = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => loginPageState();
}

class loginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool? isAdmin=false;
  bool? isCampaign=false;
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("sign in"),
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
                        // const PageHeading(
                        //   title: 'Sign in',
                        // ),


                        // const SizedBox(
                        //   height: 16,
                        // ),

                        // TextFormField(
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.allow(
                        //         RegExp("[a-zA-Z- -]"))
                        //   ],
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       name = value;
                        //     });
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Name field is required!';
                        //     } else if (value.length < 8) {
                        //       return 'Please enter valid name';
                        //     }

                        //     String patttern =
                        //         (r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
                        //     RegExp regExp = RegExp(patttern);
                        //     if (!regExp.hasMatch(value)) {
                        //       return 'Please enter valid name';
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: 'Pilgrim Name *',
                        //     hintText: 'Your full name',
                        //     isDense: true,
                        //   ),
                        // ),


                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                              if(email=='adminofrafadapp@admin.rafad'){
                                isAdmin=true;
                                //print('object');
                              }
                            });
                          },
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Email is required!';
                            }
                            if (!EmailValidator.validate(textValue)) {
                              return 'Please enter a valid email';
                            }
                            if (textValue == "adminofrafadapp@admin.rafad") {
                                //print('reached bool');
                                //print('reached bool');
                                isAdmin = true;
                              }
                            
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email *',
                            hintText: 'Your email id',
                            isDense: true,
                          ),
                        ),

                        // const SizedBox(
                        //   height: 16,
                        // ),

                        // TextFormField(
                        //   maxLength: 10,
                        //   inputFormatters: <TextInputFormatter>[
                        //     FilteringTextInputFormatter.digitsOnly
                        //   ],
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       number = value;
                        //     });
                        //   },
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return 'Phone number is required!';
                        //     }
                        //     String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        //     RegExp regExp = new RegExp(patttern);
                        //     if (!regExp.hasMatch(value)) {
                        //       return 'Please enter valid Phone number';
                        //     }
                        //     if (value.length != 10) {
                        //       return 'Phone Number must be of 10 digit';
                        //     }

                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: 'Phone number *',
                        //     hintText: 'Your phone number',
                        //     isDense: true,
                        //   ),
                        // ),
                        
                        
                        // const SizedBox(
                        //   height: 16,
                        // ),

                        // TextFormField(
                        //   maxLength: 10,
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        //   ],
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       hajId = value;
                        //     });
                        //   },
                        //   validator: (textValue) {
                        //     if (textValue == null || textValue.isEmpty) {
                        //       return 'ID is required!';
                        //     }
                        //     if (!textValue.contains(RegExp(r'[0-9]'))) {
                        //       return 'Please enter valid ID';
                        //     }
                        //     if (textValue.length != 10) {
                        //       return 'ID must be of 10 digit';
                        //     }
                        //     return null;
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: 'haj permission ID*',
                        //     hintText: 'your haj permission ID',
                        //     isDense: true,
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 16,
                        // ),

                        // TextFormField(
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.allow(
                        //         RegExp("[a-zA-Z- -]"))
                        //   ],
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       disease = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: 'chronic disease',
                        //     hintText: 'if you suffer from any chronic disease',
                        //     isDense: true,
                        //   ),
                        //),
                        // const SizedBox(
                        //   height: 16,
                        // ),

                        // TextFormField(
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.allow(
                        //         RegExp("[a-zA-Z- -]"))
                        //   ],
                        //   keyboardType: TextInputType.text,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       pharma = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: 'pharmaceutical',
                        //     hintText: 'if you are taking any pharmaceutical',
                        //     isDense: true,
                        //   ),
                        // ),
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
                          innerText: 'Sign in',
                          onPressed: () async {
                            final FirebaseAuth _auth = FirebaseAuth.instance;
      //print('reached create user');
      try {
        if (isAdmin==true) {
          //in case of an admin
          isAdmin = false;
          await _auth.signInWithEmailAndPassword(
              email: email.toString(), password: password.toString());
          email = '';
          password = '';
          //Navigator.push(
          //  context, MaterialPageRoute(builder: (context) => logOutAdmin()));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nav_admin()));

          ///home_screen_owner
        } else{
          await _auth.signInWithEmailAndPassword(
              email: email.toString(), password: password.toString());




          await FirebaseFirestore.instance
    .collection('AcceptedCampaigns')
    .doc(FirebaseAuth.instance.currentUser?.uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        isCampaign=true;
        print('reached campaign');
        print(isCampaign);
      }
    });//check if the user has account on AcceptedCampaign collection
          //on case of campaign
          //isCampaign = false;
          print('object');
          if(isCampaign!=false){
            print('i hate uni');
          }
          if(isCampaign!){
            print('reached capaign222222222');
          email = '';
          password = '';
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => nav_campaign()));

          isCampaign = false;
          }
          else{
          email = '';
          password = '';
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => nav_pilgrim()));}
        
      }} on FirebaseAuthException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content:
                    Text('Email or Password is not correct, try again please.'),
              );
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
                              /*const Text(
                                'New user ? ',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff939393),
                                    fontWeight: FontWeight.bold),
                              ),*/
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordPage()))
                                },
                                child: const Text(
                                  'Forgot password',
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



class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  const CustomFormButton(
      {Key? key, required this.innerText, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF455D83),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.validator,
    this.suffixIcon = false,
    this.isDense,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            obscureText: (widget.obscureText && _obscureText),
            decoration: InputDecoration(
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        color: const Color(0xFF7D8DBA),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              suffixIconConstraints: (widget.isDense != null)
                  ? const BoxConstraints(maxHeight: 33)
                  : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ],
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
