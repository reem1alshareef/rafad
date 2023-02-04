// import 'package:email_otp/email_otp.dart';
// import 'package:rafad1/screens/welcome_screen.dart';
// import 'package:flutter/material.dart';

// import 'otp_screen.dart';

// class send_otp extends StatefulWidget {
//   const send_otp({Key? key}) : super(key: key);

//   @override
//   State<send_otp> createState() => _send_otpState();
// }

// class _send_otpState extends State<send_otp> {
//   TextEditingController email = TextEditingController();
//   EmailOTP myauth = EmailOTP();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          
//           const SizedBox(
//             height: 60,
//             child: Text(
//               "Enter your Email to get Code",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: email,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(
//                       Icons.mail,
//                     ),
//                     suffixIcon: IconButton(
//                         onPressed: () async {
//                           myauth.setConfig(
//                               appEmail: "441200087@student.ksu.edu.sa",
//                               appName: "Email OTP",
//                               userEmail: email.text,
//                               otpLength: 4,
//                               otpType: OTPType.digitsOnly);
//                           if (await myauth.sendOTP() == true) {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text("OTP has been sent"),
//                             ));
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>   OtpScreen(myauth: myauth,)));
//                           } else {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text("Oops, OTP send failed"),
//                             ));
//                           }
//                         },
//                         icon: const Icon(
//                           Icons.send_rounded,
//                           color: Colors.teal,
//                         )),
//                     hintText: "Email Address",
//                     border: const OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }