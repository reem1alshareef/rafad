import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Chat_screen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const Chat_screen({Key? key}) : super(key: key);

  @override
  _Chat_screenState createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User sender;
  String? message;

  bool showSpinner = false;
  @override
  void initState() {
    super.initState();
    // getCurrentUser();
  }

  // void getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       signedInUser = user;
  //       print(signedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 12, 92, 119),
          title: Row(
            children: [
              Image.asset('assests/images/chat.png', height: 35),
              SizedBox(width: 10),
              Text('Chat')
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            )
          ],
        ),
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Container(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color.fromARGB(255, 41, 92, 116),
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          message = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'Write your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(13.0),
                      child: ElevatedButton(
                          onPressed: () {
                            _firestore.collection('Chat').add({
                              'sender' : sender.email,
                              'message' : message
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [Icon(Icons.send_outlined)],
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(13)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 41, 92, 116)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 41, 92, 116)))))),
                    )
                  ],
                ),
              ),
            ])));
  }
}
