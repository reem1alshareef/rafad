import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafad1/screens/CampaignView.dart';
import 'package:rafad1/screens/welcome_screen.dart';

import '../main.dart';

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  
static const String screenRoute = 'OtpScreen';
   OtpScreen({Key? key}) : super(key: key);
  EmailOTP myauth = EmailOTP();
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
appBar: AppBar(
          title: Text("OTP screen"),
          backgroundColor: const Color(0xFF455D83),
          elevation: 0,
        ),

      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.dialpad_rounded, size: 50),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "check your email and Enter the OTP",
            style: TextStyle(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Otp(
                otpController: otp1Controller,
              ),
              Otp(
                otpController: otp2Controller,
              ),
              Otp(
                otpController: otp3Controller,
              ),
              Otp(
                otpController: otp4Controller,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "waiting to the OTP",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
            if (await widget.myauth.verifyOTP(otp: otp1Controller.text +
                    otp2Controller.text +
                    otp3Controller.text +
                    otp4Controller.text) == true) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("OTP is verified"),
                ));
                
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CampaignView()));
              }
            },
            child: const Text(
              "Confirm",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
