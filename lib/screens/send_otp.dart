import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:rafad1/screens/CampaignView.dart';

import 'otp_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          
          const SizedBox(
            height: 60,
            child: Text(
              "Enter your Email to get Code",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          myauth.setConfig(
                              appEmail: "contact@hdevcoder.com",
                              appName: "Rafad OTP",
                              userEmail: email.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if ( myauth.sendOTP() == true) {
                            
                            // ignore: use_build_context_synchronously
                            
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>   OtpScreen()));
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        },
                        
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.teal,
                        )
                        ),
                    hintText: "Email Address",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}