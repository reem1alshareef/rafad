import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/navigation/nav_bar.dart';
import 'package:rafad1/screens/LoginPage.dart';
//import 'package:rafad1/screens/logOutPilgrim.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rafad1/screens/otp_screen.dart';
import 'package:rafad1/screens/send_otp.dart';
import 'package:toast/toast.dart';
import 'package:rafad1/screens/welcome_screen.dart';
import 'package:email_otp/email_otp.dart';

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
  final _firestore = FirebaseFirestore.instance;
  
  //////////////////////////////////////////
TextEditingController otp1Controller = TextEditingController();
TextEditingController emailOTP =  TextEditingController();
  // TextEditingController otp = new TextEditingController();
  EmailOTP myauth = EmailOTP();
  /////////////////////////////////////////
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
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: emailOTP,
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
                        
                        ////////////////////////////////////////////////////////////
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //       controller: emailOTP,
                    //       decoration:
                    //           const InputDecoration(hintText: "enter valid email to verify")),
                    // ),
                    // ElevatedButton(
                    //     onPressed: () async {
                    //       myauth.setConfig(
                    //         appEmail: "reemsh65@gmail.com", 
                    //         appName: "Email OTP",
                    //         userEmail: emailOTP.text,
                    //         otpLength: 6,
                    //         otpType: OTPType.digitsOnly
                    //       );
                    //       if (await myauth.sendOTP() == true) {
                    //         print("send");
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(const SnackBar(
                    //           content: Text("OTP has been sent"),
                    //         ));
                    //       } else {
                    //         print("unsend");
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(const SnackBar(
                    //           content: Text("Oops, OTP send failed"),
                    //         ));
                    //       }
                    //     },
                    //     child: const Text("Send OTP")),

              
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //       controller: otp,
                    //       decoration:
                    //           const InputDecoration(hintText: "Enter OTP")),
                    // ),
                    // ElevatedButton(
                    //     onPressed: () async {
                    //       if (await myauth.verifyOTP(otp: otp.text) == true) {
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(const SnackBar(
                    //           content: Text("OTP is verified"),
                    //         ));
                    //         print("OTP is verified");
                    //       } else {
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(const SnackBar(
                    //           content: Text("Invalid OTP"),

                    //         ));
                    //       }
                    //     },
                    //     child: const Text("Verify")),

                        
                        ///////////////////////////////////////////////////////////
                        
                        CustomFormButton(
                          innerText: 'Sign in',
                          onPressed: () async {
                            // EmailOTP myauth = EmailOTP();
                            // final FirebaseAuth auth = FirebaseAuth.instance;
                            //  auth.signInWithEmailAndPassword(
                            // email: email.toString(), password: password.toString());
                            // myauth.setConfig(
                            // appEmail: "reemsh65@gmail.com",
                            // appName: "Rafad",
                            // userEmail: email,
                            // otpLength: 6,
                            // otpType: OTPType.digitsOnly
                            // );
                            
        //                     TextEditingController _textFieldController = TextEditingController();
                            
        //                   return showDialog(
        // context: context,
        // builder: (context) {
        //   return AlertDialog(
        //     title: Text('OTP has been sent successfully please check your email'),
        //     content: TextField(
        //       controller: _textFieldController,
        //       textInputAction: TextInputAction.go,
        //       keyboardType: TextInputType.numberWithOptions(),
        //       decoration: InputDecoration(hintText: "Enter the OTP here"),
        //     ),
        //     actions: <Widget>[
        //       new ElevatedButton(
        //         child: new Text('Submit'),
        //         onPressed: () async {

        //         },
        //       )
        //     ],
        //   );
        // });

                            
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
        
        TextEditingController _textFieldController = TextEditingController();
                            
                          return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('please verify your email'),
            // content: TextField(
            //   controller: _textFieldController,
            //   textInputAction: TextInputAction.go,
            //   keyboardType: TextInputType.numberWithOptions(),
            //   decoration: InputDecoration(hintText: "Enter the OTP here"),
            // ),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text('ok'),
                onPressed: () async {
                   Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyApp()));
                          
                            // myauth.setConfig(
                            //   appEmail: "441200087@student.ksu.edu.sa",
                            //   appName: "Rafad",
                            //   userEmail: emailOTP,
                            //   otpLength: 4,
                            //   otpType: OTPType.digitsOnly);
                            //   print("send Otp");
                },
              ),
              // new ElevatedButton(
              //   child: new Text('verify OTP'),
              //   onPressed: () async {
              //     if (await myauth.verifyOTP(otp: otp1Controller.text) == true) ;
              //     {
              //       print("ok");
              //     }
              //   },
              // )
            ],
          );
        });

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
        
      }

      } on FirebaseAuthException catch (e) {
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
                              const Text(
                                'New user ? ',
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
                                              const WelcomeScreen()))
                                },
                                child: const Text(
                                  'Sign-up',
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

