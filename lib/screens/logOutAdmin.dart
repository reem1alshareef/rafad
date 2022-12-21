
// import 'package:flutter/cupertino.dart';

// class myApp extends StatelessWidget{
//   const myApp({super.key});

// Widget buildLogout() => TextButton(
//         // leading: IconWidget(
//         //   icon: Icons.logout,
//         //   color: Color.fromARGB(255, 221, 112, 112),
//         // ),
//         // title: 'تسجيل الخروج',
//         // subtitle: '',

//         child: Container(
//           child: Row(
//             children: [
//               IconWidget(
//                 icon: Icons.logout,
//                 color: Color.fromARGB(255, 221, 112, 112),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text('تسجيل الخروج',
//                   style: TextStyle(
//                       color: Color.fromARGB(255, 221, 112, 112),
//                       fontFamily: "Tajawal",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16)),
//             ],
//           ),
//         ),
//         onPressed: () async {
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return AlertDialog(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20)),
//                   title: Center(
//                     child: Text(
//                       "تنبيه",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w700,
//                         color: Color.fromARGB(255, 221, 112, 112),
//                         fontFamily: "Tajawal",
//                       ),
//                     ),
//                   ),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                         child: Container(
//                           width: 250,
//                           height: 50,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                             fit: BoxFit.scaleDown,
//                             image: AssetImage('assets/images/logout.png'),
//                           )),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Center(
//                           child: Text(
//                         'سيتم تسجيل خروجك من الحساب',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w700,
//                           color: Color.fromARGB(255, 26, 96, 91),
//                           fontFamily: "Tajawal",
//                         ),
//                       )),
//                     ],
//                   ),
//                   actions: <Widget>[
//                     TextButton(
//                       child: Text("تراجع"),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     TextButton(
//                       child: Text("تسجيل خروج",
//                           style: TextStyle(color: Colors.red)),
//                       onPressed: () {
//                         //Navigator.of(context).pop();
//                         // FirebaseAuth.instance.signOut();
//                         // Navigator.of(context).pushNamedAndRemoveUntil(
//                         //     "/login", (Route<dynamic> route) => false);
//                         Navigator.of(context, rootNavigator: true)
//                             .pushReplacement(MaterialPageRoute(
//                                 builder: (context) => new login()));
//                         Fluttertoast.showToast(
//                           msg: "تم تسجيل الخروج  بنجاح",
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.CENTER,
//                           timeInSecForIosWeb: 3,
//                           backgroundColor: Color.fromARGB(255, 26, 96, 91),
//                           textColor: Colors.white,
//                           fontSize: 18.0,
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               });
//         },
//         //==========================================================
//       );
// }
